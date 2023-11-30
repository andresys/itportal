class ImagesController < ApplicationController
  def destroy
    @image = ActiveStorage::Blob.find_signed(params[:id])
    # @asset = Asset.joins(:images_attachments).where(images_attachments: {blob_id: @image}).first
    @image.attachments.first.purge
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to request.referer || root_path, notice: "Asset was successfully destroyed." }
    end
  end  
end