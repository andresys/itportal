class ImportAssetsFrom1cJob < ApplicationJob
  def perform(*args)
    status.update(step: "Import assets from 1c HTTP service")
    p "Import assets from 1c HTTP service"

    data = AccountingImportService.call("/hs/itportal/assets")
    if data.any?
      status.update(step: "Parsing data from JSON")
      p "Parsing data from JSON"
      assets = assets_from(data)
      status.update(step: "Save assets to database")
      p "Save assets to database"
      Asset.import assets, ignore: true
      status.update(step: "Ok")
      p "Ok"
    end
  end

private

  def assets_from(assets)
    progress.total = assets.count

    @organizations = {}
    @mols = {}
    @accounts = {}

    assets.map do |asset|
      progress.increment

      unless @organizations.has_key? asset['organization_code']
        organization = Organization.find_by_name_and_code(asset['organization'], nil)
        organization.update(code: asset['organization_code']) if organization
        organization = Organization.create_with(name: asset['organization']).find_or_create_by(code: asset['organization_code']) unless organization
        @organizations[asset['organization_code']] = organization
      end

      unless @mols.has_key? asset['mol_code']
        mol = Mol.find_by_name_and_code(asset['mol'], nil)
        mol.update(code: asset['mol_code']) if mol
        mol = Mol.create_with(name: asset['mol']).find_or_create_by(code: asset['mol_code']) unless mol
        @mols[asset['mol_code']] = mol
      end

      unless @accounts.has_key? asset['account_number']
        account = Account.find_by_name_and_code(asset['account_number'], nil)
        account.update(code: asset['account_number']) if account
        account = Account.create_with(name: asset['account_number']).find_or_create_by(code: asset['account_number']) unless account
        @accounts[asset['account_number']] = account
      end

      update_finded_asset(asset) || Asset.new(asset_params asset)
    end
  end

  def update_finded_asset asset
    finded = Asset.find_by("code = ? OR inventory_number = ?", asset['code'], asset['inventory_number'])
    finded&.update(asset_params asset)
    finded
  end

  def asset_params asset
    return {
      name: !asset['name'].blank? && asset['name'] || nil,
      code: !asset['code'].blank? && asset['code'] || nil,
      inventory_number: !asset['inventory_number'].blank? && asset['inventory_number'] || nil,
      date: !asset['date'].blank? && Date.strptime(asset['date'], "%d.%m.%Y") || nil,
      start_date: !asset['start_date'].blank? && Date.strptime(asset['start_date'], "%d.%m.%Y") || nil,
      useful_life: !asset['useful_life'].blank? && asset['useful_life']&.to_i || nil,
      cost: !asset['cost'].blank? && asset['cost']&.to_f || nil,
      count: !asset['count'].blank? && asset['count']&.to_i || 1,
      account: !asset['account_number'].blank? && @accounts[asset['account_number']] || nil,
      organization: !asset['organization_code'].blank? && @organizations[asset['organization_code']] || nil,
      mol: !asset['mol_code'].blank? && @mols[asset['mol_code']] || nil
    }
  end
end
