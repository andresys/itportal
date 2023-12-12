class Directories::RoomsController < DirectoriesController
  layout "application"
  before_action :set_location
  before_action :set_room, only: %i[show update destroy]

  def new
    @room = Room.new room_params
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to [:directories, :locations], notice: "Room was successfully created." }
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
      if @room.update(room_params)
        format.html { redirect_to [:directories, :locations], notice: "Room was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, :locations], notice: "Room was successfully destroyed." }
    end
  end

private
  def room_params
    params.fetch(:room, {}).permit(:name).merge(location: @location)
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_room
    @room = Room.find(params[:id])
  end
end