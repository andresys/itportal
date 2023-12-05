class Directories::TitlesController < DirectoriesController
  layout "application"
  before_action :set_organization

  def new
    @title = Title.new title_params
  end

  def create
    @title = Title.new title_params
    
    respond_to do |format|
      if @title.save
        format.html { redirect_to directories_organization_staffing_path(@organization), notice: "Title was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

private
  def title_params
    params.fetch(:title, {}).permit(:name, :department_id).merge(organization: @organization)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end