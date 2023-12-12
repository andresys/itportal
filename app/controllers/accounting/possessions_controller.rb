class Accounting::PossessionsController < ApplicationController
  before_action :set_model
  before_action :set_possession, only: %i[show update destroy]

  def index
    redirect_to [:new, :accounting, @model, :possession]
  end

  def create
    @possession = Possession.new(possession_params)
    @possession.possessionable = @model

    respond_to do |format|
      if @possession.save
        format.html { redirect_to [:accounting, @model], notice: "Possession was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @possession = Possession.new possession_params
  end

  def show
    render :edit
  end

  def update
    respond_to do |format|
      if @possession.update(possession_params)
        format.html { redirect_to [:accounting, @model], notice: "Possession was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @possession.destroy
    respond_to do |format|
      format.html { redirect_to [:accounting, @model], notice: "Possession was successfully destroyed." }
    end
  end

private
  def set_model
    @asset = Asset.find(params[:asset_id]) if params[:asset_id]
    @material = Material.find(params[:material_id]) if params[:material_id]

    @model = @asset || @material
    if params[:asset_id] || params[:material_id]
      raise "Model not found" unless @model
    end
  end

  def set_possession
    @possession = Possession.find(params[:id])
  end

  def possession_params
    params.fetch(:possession, {}).permit(:employee_id, :room_id, :count)
  end
end