class Directories::OrganizationsController < DirectoriesController
  def index
    @organizations = Organization.where({}).page(params[:page])
  end

  def new
  end

  def create
  end
end