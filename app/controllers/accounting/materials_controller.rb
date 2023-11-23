class Accounting::MaterialsController < ApplicationController
  before_action :set_material, only: %i[show]
  before_action :set_back_url, :only => :index

  def index
    @query = request.query_parameters

    @mol = Mol.find_by_id(params[:mol] || 9)
    @location = Location.find_by_id(params[:location])

    query_parameters = {}

    if @mol
      query_parameters.merge!(mol: {id: @mol})
    end

    if @location
      query_parameters.merge!(location: {id: @location})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @materials = Material.left_joins(:uids).joins(:account, :mol, :location)
      .where(query_parameters)
      .where(Material.arel_table[:name]
      .matches("%#{params[:q]}%"))
      .page(page).per(page_size)
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
end