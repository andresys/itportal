class ImportMaterialsFrom1cJob < ApplicationJob
  def perform(*args)
    set_step "Import materials from 1c HTTP service"
    data = AccountingImportService.call("/hs/itportal/materials") {|step| set_step step}

    return unless data.respond_to?(:any?) && data.any?

    set_progress data.count
    job = Job.find_by(job_id: @job_id)
    ids = []
    histories = []

    set_step "Parsing data from JSON and save material to database"

    @organizations = {}
    @mols = {}
    @accounts = {}

    data.each do |material|
      set_progress

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

      values = material_params material
      if finded = Material.find_by(code: values[:code], mol_id: values[:mol_id])
        values.delete_if {|k,v| v == finded[k]}
        if values.any?
          histories << JobHistory.new(job: job, record: finded, action: 'change', values: finded.slice(values.keys))
          finded.update(values)
        end
        ids << finded.id
      else
        created = Material.create(values)
        histories << JobHistory.new(job: job, record: created, action: 'add')
        ids << created.id
      end
    end

    set_step "Removing removed materials from database"
    removed_materials = Material.where(delete_mark: false).where.not(id: ids)
    removed_materials.each { |material| histories << JobHistory.new(job: job, record: material, action: 'remove') }
    removed_materials.update_all(delete_mark: true)

    set_step "Saving materials histories"
    JobHistory.import histories
  end

private
  def material_params material
    return {
      name: !material['name'].blank? && material['name'] || nil,
      code: !material['code'].blank? && material['code'] || nil,
      cost: !material['cost'].blank? && material['cost']&.to_f || nil,
      count: !material['count'].blank? && material['count']&.to_i || 1,
      account_id: !material['account_number'].blank? && @accounts[material['account_number']].id || nil,
      organization_id: !material['organization_code'].blank? && @organizations[material['organization_code']].id || nil,
      mol_id: !material['mol_code'].blank? && @mols[material['mol_code']].id || nil
    }
  end
end
