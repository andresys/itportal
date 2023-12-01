class Directories::LocationsController < DirectoriesController
  def index
    # @locations = Location.where({}).page(params[:page])
    @locations = params[:parent] && (!params[:parent].empty? && Location.where("parent_id = ?", params[:parent]) || Location.roots) || Location.all
  end

  def new
    @location = Location.new parent_id: params[:parent]
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to directories_locations_path, notice: "Location was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

private
  def location_params
    params.fetch(:location, {}).permit(:name, :parent_id)
  end
end