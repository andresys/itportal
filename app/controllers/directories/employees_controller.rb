class Directories::EmployeesController < DirectoriesController
  def index
    page_size = params[:per] || 10
    page = params[:page] || 0

    @employees = Employee.where.not(name: nil).page(page).per(page_size)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to directories_employees_path, notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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
    params.fetch(:employee, {}).permit(:name)
  end
end