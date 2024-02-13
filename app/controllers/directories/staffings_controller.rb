class Directories::StaffingsController < DirectoriesController
  layout "application"
  before_action :set_organization
  before_action :save_back_url, :only => :show

  def show
    @current_tab = ['departments', 'titles', 'employees'].include?(params[:tab]) && params[:tab] || 'departments'

    @departments = @organization.department.self_and_descendants
  end

  def create
    Department.create(organization: @organization, name: @organization.name) unless @organization.department

    respond_to do |format|
      format.html { redirect_to directories_organization_staffing_path(@organization), notice: "Staffing table was successfully created." }
    end
  end

  def destroy
    @organization.department.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "Staffing was successfully destroyed." }
    end
  end

private
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end