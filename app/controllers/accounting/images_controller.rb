class Accounting::ImagesController < ApplicationController
  before_action :set_image, only: %i[ show destroy]

  layout false

  def show
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
private
  def set_image
    @asset = Asset.find(params[:asset_id])
    @image = @asset.find_by_id(params[:id])
  end
end