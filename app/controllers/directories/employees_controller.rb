class Directories::EmployeesController < DirectoriesController
  before_action :set_employee, only: %i[show update destroy]

  def index
    employee = Employee.arel_table
    matches_string =  ->(p){ employee[p].lower.matches("%#{params[:q]&.downcase}%") }

    @query = request.query_parameters

    query_parameters = {}

    page_size = params[:per] || 10
    page = params[:page] || 0

    @employees = Employee.left_joins(nil)
      .where.not(name: nil)
      .where(query_parameters)
      .where(matches_string.(:name))
      .group(:id)
    
    @employees = @employees.page(page).per(page_size)
  end

  def new
    @employee = Employee.new
  end

  def show
    render :edit
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.images.attach(params[:employee][:images]) if params.dig(:employee, :images).present? && @employee.valid?

    respond_to do |format|
      if @employee.save
        format.html { redirect_to [:directories, :employees], notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        @employee.images.attach(params[:employee][:images]) if params.dig(:employee, :images).present?

        format.html { redirect_to [:directories, :employees], notice: "Employee was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, @employee], notice: "Employee was successfully destroyed." }
    end
  end

  def import
    @job = ImportEmployeesJob.perform_later
    respond_to do |format|
      format.html { redirect_to directories_employees_path, notice: "Job import Employees was successfully created." }
      format.json { render show: @job, status: :ok }
    end
  end

private
  def employee_params
    params.fetch(:employee, {}).permit(:name, :organization_id, :title_id)
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end
end