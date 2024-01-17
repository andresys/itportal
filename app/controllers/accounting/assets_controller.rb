class Accounting::AssetsController < ApplicationController
  before_action :set_asset, only: %i[show edit update destroy]
  
  def index
    asset = Asset.arel_table
    matches_string =  ->(p){ asset[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters
    @statuses = Asset.statuses.merge('all' => -1)
    @status = @statuses[params[:status]] && params[:status] || 'on_balance'

    @mol = Mol.find_by_id(params[:mol] ||= nil)
    @room = Room.find_by_id(params[:location])
    @employee = Employee.find_by_id(params[:employee])

    query_parameters = {delete_mark: false}

    if @status
      accounts = { 'on_balance' => ["101.36", "101.34"], 'out_balance' => ["21.36", "21.34"], 'storage' => ["102"] }
      accounts = accounts[@status]
      query_parameters.merge!(account: {code: accounts}) if accounts&.any?
    end

    if @mol
      query_parameters.merge!(mol: {id: @mol})
    end

    if @room
      query_parameters.merge!(rooms: {id: @room})
    end

    if @employee
      query_parameters.merge!(employees: {id: @employee})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @assets = Asset.left_joins(:uids, :images_attachments, :account, :mol, :rooms, :employees)
      .where(query_parameters)
      .where(matches_string.(:name).or(matches_string.(:inventory_number)))
      .group(:id)
    
    @assets = @assets.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @assets = @assets.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s
    
    @assets = @assets.page(page).per(page_size)
  end

  def update
    respond_to do |format|
      if @asset.update(asset_params)
        @asset.images.attach(params[:asset][:images]) if params.dig(:asset, :images).present?

        format.html { redirect_to [:accounting, @asset], notice: "Asset was successfully updated." }
        format.json { render :show, status: :ok, location: [:accounting, @asset] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @asset.destroy
        format.html { redirect_to @back_url, notice: "Asset was successfully destroyed." }
        format.json { render status: :ok }
      else
        format.html { redirect_to [:account, @asset], notice: "Error! Asset don't mark for removing." }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_asset
    ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
    @asset = ids.kind_of?(Array) && ids.map{|id| Asset.find(id)} || Asset.find(ids)
  end

  def asset_params
    params.fetch(:asset, {}).permit(:name, :type_id)
  end
end
