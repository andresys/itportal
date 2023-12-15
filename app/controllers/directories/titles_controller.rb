class Directories::TitlesController < DirectoriesController
  layout "application"
  before_action :set_organization
  before_action :set_title, only: %i[show update destroy]

  def new
    @title = Title.new title_params
  end

  def create
    @title = Title.new title_params
    @title.employee = Employee.find(params[:title][:employee_id]) if params.dig(:title, :employee_id).present? && @title.valid?
    
    respond_to do |format|
      if @title.save
        format.html { redirect_to directories_organization_staffing_path(@organization), notice: "Title was successfully created." }
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
      if @title.update(title_params)
        @title.employee = Employee.find(params[:title][:employee_id]) if params.dig(:title, :employee_id).present? && @title.valid?

        format.html { redirect_to [:directories, @organization, :staffing], notice: "Title was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @title.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, @organization, :staffing], notice: "Title was successfully destroyed." }
    end
  end

private
  def title_params
    params.fetch(:title, {}).permit(:name, :department_id).merge(organization: @organization)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_title
    @title = Title.find(params[:id])
  end
end