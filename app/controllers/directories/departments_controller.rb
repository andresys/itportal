class Directories::DepartmentsController < DirectoriesController
  layout "application"
  before_action :set_organization

  def new
    @department = Department.new department_params
  end

  def create
    @department = Department.new department_params
    
    respond_to do |format|
      if @department.save
        format.html { redirect_to directories_organization_staffing_path(@organization), notice: "Department was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

private
  def department_params
    params.fetch(:department, {}).permit(:name, :parent_id)
    #.merge(organization: @organization)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end 