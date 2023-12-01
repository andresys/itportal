class Directories::EmployeesController < DirectoriesController
  def index
    @employees = Employee.where({}).page(params[:page])
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

private
  def employee_params
    params.fetch(:employee, {}).permit(:name)
  end
end