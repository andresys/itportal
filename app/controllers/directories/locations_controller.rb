class Directories::LocationsController < DirectoriesController
  before_action :set_location, only: %i[show update destroy]

  def index
    # @locations = Location.where({}).page(params[:page])
    @locations = params[:parent] && (!params[:parent].empty? && Location.where("parent_id = ?", params[:parent]) || Location.roots) || Location.all
  end

  def new
    @location = Location.new location_params
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to [:directories, :locations], notice: "Location was successfully created." }
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
      if @location.update(location_params)
        format.html { redirect_to [:directories, :locations], notice: "Location was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, :locations], notice: "Location was successfully destroyed." }
    end
  end

private
  def location_params
    params.fetch(:location, {}).permit(:name, :parent_id)
  end

  def set_location
    @location = Location.find(params[:id])
  end
end