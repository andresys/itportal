class JobsController < ApplicationController
  before_action { authorize(@job || Job) }

  def index
    @current_tab = ['changed', 'all'].include?(params[:tab]) && params[:tab] || 'changed'

    @jobs = Job.left_joins(:job_histories).group(:id)

    @jobs = @jobs.having("COUNT(job_histories) > 0") if @current_tab == 'changed'

    @jobs = @jobs.page(page).per(page_size)
  end
  
  def new
    @job = Job.new
  end
  
  def show
    @job = Job.left_joins(:job_histories).find(params[:id])
    @add_histories = JobHistory.includes(:record).where(job: @job, action: 'add')
    @remove_histories = JobHistory.includes(:record).where(job: @job, action: 'remove')
    @change_histories = JobHistory.includes(:record).where(job: @job, action: 'change')
  end

  def create
    case job_params[:type]
    when 'import_assets_from_1c'
      @job = ImportAssetsFrom1cJob.perform_later
      respond_to do |format|
        format.html { redirect_to @back_url, notice: "Job import Assets was successfully created." }
        format.json { render show: @job, status: :ok }
      end
    when 'import_materials_from_1c'
      @job = ImportMaterialsFrom1cJob.perform_later
      respond_to do |format|
        format.html { redirect_to @back_url, notice: "Job import Materials was successfully created." }
        format.json { render show: @job, status: :ok }
      end
    when 'import_employees'
      @job = ImportEmployeesJob.perform_later
      respond_to do |format|
        format.html { redirect_to @back_url, notice: "Job import Employees was successfully created." }
        format.json { render show: @job, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to @back_url, notice: "Job type not found" }
        format.json { render json: {error: "Job type not found"}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "Job was successfully destroyed." }
    end
  end

private
  def job_params
    params.fetch(:job, {}).permit(:type)
  end
end