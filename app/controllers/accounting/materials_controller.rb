class Accounting::MaterialsController < ApplicationController
  before_action :set_material, only: %i[show update destroy]
  before_action :set_back_url, :only => :index

  def index
    material = Material.arel_table
    matches_string =  ->(p){ material[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters

    @mol = Mol.find_by_id(params[:mol] ||= nil)
    @location = Location.find_by_id(params[:location])
    @employee = Employee.find_by_id(params[:employee])

    query_parameters = {}

    if @mol
      query_parameters.merge!(mol: {id: @mol})
    end

    if @location
      query_parameters.merge!(location: {id: @location})
    end

    if @employee
      query_parameters.merge!(employee: {id: @employee})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @materials = Material.left_joins(:uids, :images_attachments, :account, :mol, :location, :employee)
      .where(query_parameters)
      .where(matches_string.(:name))

    @materials = @materials.group(:id).having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @materials = @materials.group(:id).having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s

    @materials = @materials.page(page).per(page_size)
  end

  def update
    respond_to do |format|
      if @material.update(material_params)
        @material.images.attach(params[:material][:images]) if params.dig(:material, :images).present?

        format.html { redirect_to [:accounting, @material], notice: "Material was successfully updated." }
        format.json { render :show, status: :ok, location: [:accounting, @material] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to [:accounting, @material], notice: "Material was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    @job = ImportMaterialsFrom1cJob.perform_later
    respond_to do |format|
      format.html { redirect_to accounting_materials_path, notice: "Run job: import assets from 1c." }
      # format.html { redirect_to job_path(@job.job_id), notice: "Run job: import assets from 1c." }
      format.json { render show: @job, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
      @material = ids.kind_of?(Array) && ids.map{|id| Material.find(id)} || Material.find(ids)
    end

    def set_back_url
      session[:back_url] = request.url
    end

    def material_params
      params.fetch(:material, {}).permit(:name, :description, :cost, :count)
    end
end