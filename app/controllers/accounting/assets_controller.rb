class Accounting::AssetsController < AccountingController
  before_action :set_accounting, only: %i[show edit update destroy]
  before_action { authorize(@accounting || Asset) }
  
  def index
    accounting = Asset.arel_table
    matches_string =  ->(p){ accounting[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters
    @status = ['on_balance', 'out_balance', 'storage', 'disposal', 'all'].include?(params[:status]) && params[:status] || 'on_balance'

    @mol = Mol.find_by_id(params[:mol] ||= nil)
    @room = Room.find_by_id(params[:location])
    @employee = Employee.find_by_id(params[:employee])

    query_parameters = {delete_mark: false}

    if @status
      accounts = { 'on_balance' => ["101.36", "101.34"], 'out_balance' => ["21.36", "21.34"], 'storage' => ["02.3"], 'disposal' => ["102.00"] }
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

    @accountings = Asset.left_joins(:uids, :images_attachments, :account, :mol, :rooms, :employees)
      .where(query_parameters)
      .where(matches_string.(:name).or(matches_string.(:inventory_number)))
      .group(:id)
    
    @accountings = @accountings.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @accountings = @accountings.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s
    
    @accountings = @accountings.page(page).per(page_size)
  end

  def show
    @note = Note.new(date: Date.current)
  end

  def update
    respond_to do |format|
      if @accounting.update(accounting_params)
        @accounting.images.attach(params[:asset][:images]) if params.dig(:asset, :images).present?

        format.html { redirect_to [:accounting, @accounting], notice: "Asset was successfully updated." }
        format.turbo_stream { @accounting }
        format.json { render :show, status: :ok, location: [:accounting, @accounting] }
      else
        format.html { render :edit }
        format.json { render json: @accounting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @accounting.destroy
        format.html { redirect_to @back_url, notice: "Asset was successfully destroyed." }
        format.json { render status: :ok }
      else
        format.html { redirect_to [:accounting, @accounting], notice: "Error! Asset don't mark for removing." }
        format.json { render json: @accounting.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_accounting
    ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
    @accounting = ids.kind_of?(Array) && ids.map{|id| Asset.find(id)} || Asset.find(ids)
  end

  def accounting_params
    params.fetch(:asset, {}).permit(:name, :type_id)
  end
end
