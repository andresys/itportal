class ImportMaterialsFrom1cJob < ApplicationJob
  include ActiveJob::Status
  
  queue_as :default

  def perform(*args)
    status.update(step: "Import materials from 1c HTTP service")
    p "Import materials from 1c HTTP service"

    data = AccountingImportService.call("/hs/itportal/materials")
    if data.any?
      status.update(step: "Parsing data from JSON")
      p "Parsing data from JSON"
      materials = materials_from(data)
      status.update(step: "Save materials to database")
      p "Save materials to database"

      # binding.pry
      Material.import materials, ignore: true
      status.update(step: "Ok")
      p "Ok"
    end
  end

private

  def materials_from(materials)
    progress.total = materials.count

    @organizations = {}
    @mols = {}
    @accounts = {}

    materials.map do |material|
      progress.increment

      unless @organizations.has_key? material['organization_code']
        organization = Organization.find_by_name_and_code(material['organization'], nil)
        organization.update(code: material['organization_code']) if organization
        organization = Organization.create_with(name: material['organization']).find_or_create_by(code: material['organization_code']) unless organization
        @organizations[material['organization_code']] = organization
      end

      unless @mols.has_key? material['mol_code']
        mol = Mol.find_by_name_and_code(material['mol'], nil)
        mol.update(code: material['mol_code']) if mol
        mol = Mol.create_with(name: material['mol']).find_or_create_by(code: material['mol_code']) unless mol
        @mols[material['mol_code']] = mol
      end

      unless @accounts.has_key? material['account_number']
        account = Account.find_by_name_and_code(material['account_number'], nil)
        account.update(code: material['account_number']) if account
        account = Account.create_with(name: material['account_number']).find_or_create_by(code: material['account_number']) unless account
        @accounts[material['account_number']] = account
      end

      update_finded_material(material) || Material.new(material_params material)
    end
  end

  def update_finded_material material
    finded = Material.find_by("code = ?", material['code'])
    finded&.update(material_params material)
    finded
  end

  def material_params material
    return {
      name: !material['name'].blank? && material['name'] || nil,
      code: !material['code'].blank? && material['code'] || nil,
      cost: !material['cost'].blank? && material['cost']&.to_f || nil,
      count: !material['count'].blank? && material['count']&.to_i || 1,
      account: !material['account_number'].blank? && @accounts[material['account_number']] || nil,
      organization: !material['organization_code'].blank? && @organizations[material['organization_code']] || nil,
      mol: !material['mol_code'].blank? && @mols[material['mol_code']] || nil
    }
  end
end
