class Directories::EmployeesController < DirectoriesController
  layout "application", except: :index
  before_action :set_employee, only: %i[show update destroy]

  def index
    employee = Employee.arel_table
    matches_string =  ->(p){ employee[p].lower.matches("%#{params[:q]&.downcase}%") }

    @organization = Organization.find_by_id(params[:organization] ||= nil)

    @query = request.query_parameters

    query_parameters = {}

    if @organization || params[:organization] == '0'
      query_parameters.merge!(organization: {id: @organization})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @employees = Employee.left_joins(:images_attachments, :organization)
      .where.not(name: nil)
      .where(query_parameters)
      .where(matches_string.(:name))
      .group(:id)
    
    @employees = @employees.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @employees = @employees.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s

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
        format.html { redirect_to @back_url, notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        @employee.images.attach(params[:employee][:images]) if params.dig(:employee, :images).present?

        format.html { redirect_to @back_url, notice: "Employee was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "Employee was successfully destroyed." }
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