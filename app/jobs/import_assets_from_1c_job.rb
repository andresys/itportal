class ImportAssetsFrom1cJob < ApplicationJob
  def perform(*args)
    set_step "Import assets from 1c HTTP service"
    data = AccountingImportService.call("/hs/itportal/assets") {|step| set_step step}

    return unless data.respond_to?(:any?) && data.any?

    set_progress data.count
    job = Job.find_by(job_id: @job_id)
    ids = []
    histories = []
    
    set_step "Parsing data from JSON and save assets to database"

    @organizations = {}
    @mols = {}
    @accounts = {}
    
    data.each do |asset|
      set_progress
      
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
      
      values = asset_params asset
      if finded = Asset.find_by(code: values[:code], inventory_number: values[:inventory_number], mol_id: values[:mol_id])
        values.delete_if {|k,v| v == finded[k]}
        if values.any?
          histories << JobHistory.new(job: job, record: finded, action: 'change', values: finded.slice(values.keys))
          finded.update(values)
        end
        ids << finded.id
      else
        created = Asset.create(values)
        histories << JobHistory.new(job: job, record: created, action: 'add')
        ids << created.id
      end
    end

    set_step "Removing removed assets from database"
    removed_assets = Asset.where(delete_mark: false).where.not(id: ids)
    removed_assets.each { |asset| histories << JobHistory.new(job: job, record: asset, action: 'remove') }
    removed_assets.update_all(delete_mark: true)

    set_step "Saving assets histories"
    JobHistory.import histories
  end
  
private
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
      account_id: !asset['account_number'].blank? && @accounts[asset['account_number']].id || nil,
      organization_id: !asset['organization_code'].blank? && @organizations[asset['organization_code']].id || nil,
      mol_id: !asset['mol_code'].blank? && @mols[asset['mol_code']].id || nil
    }
  end
end
