class Directories::OrganizationsController < DirectoriesController
  def index
    @organizations = Organization.where({}).page(params[:page])
  end
end