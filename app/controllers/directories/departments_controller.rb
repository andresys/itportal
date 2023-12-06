class Directories::DepartmentsController < DirectoriesController
  layout "application"
  before_action :set_organization
  before_action :set_department, only: %i[show update destroy]

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

  def show
    render :edit
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to [:directories, @organization, :staffing], notice: "Department was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, @organization, :staffing], notice: "Title was successfully destroyed." }
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

  def set_department
    @department = Department.find(params[:id])
  end
end 