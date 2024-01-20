class Accounting::MaterialsController < ApplicationController
  before_action :set_accounting, only: %i[show edit update destroy]

  def index
    accounting = Material.arel_table
    matches_string =  ->(p){ accounting[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters

    @mol = Mol.find_by_id(params[:mol] ||= nil)
    @room = Room.find_by_id(params[:location])
    @employee = Employee.find_by_id(params[:employee])

    query_parameters = {delete_mark: false}

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

    @accountings = Material.left_joins(:uids, :images_attachments, :account, :mol, :rooms, :employees)
      .where(query_parameters)
      .where(matches_string.(:name))

    @accountings = @accountings.group(:id).having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @accountings = @accountings.group(:id).having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s

    @accountings = @accountings.page(page).per(page_size)
  end

  def show
    # @note = @accounting.notes.build date: Date.current
    @note = Note.new(date: Date.current)
  end

  def update
    respond_to do |format|
      if @accounting.update(accounting_params)
        @accounting.images.attach(params[:material][:images]) if params.dig(:material, :images).present?

        format.html { redirect_to [:accounting, @accounting], notice: "Material was successfully updated." }
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
        format.html { redirect_to @back_url, notice: "Material was successfully destroyed." }
        format.json { render status: :ok }
      else
        format.html { redirect_to [:accounting, @accounting], notice: "Error! Material don't mark for removing." }
        format.json { render json: @accounting.errors, status: :unprocessable_entity }
      end
    end
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_accounting
    ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
    @accounting = ids.kind_of?(Array) && ids.map{|id| Material.find(id)} || Material.find(ids)
  end

  def accounting_params
    params.fetch(:material, {}).permit(:name, :type_id)
  end
end