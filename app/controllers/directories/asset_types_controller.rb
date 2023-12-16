class Directories::AssetTypesController < DirectoriesController
  layout "application", except: :index
  before_action :set_asset_type, only: %i[show update destroy]

  def index
    @asset_types = params[:parent] && (!params[:parent].empty? && AssetType.where("parent_id = ?", params[:parent]) || AssetType.roots) || AssetType.all
  end

  def new
    @asset_type = AssetType.new asset_type_params
  end

  def create
    @asset_type = AssetType.new asset_type_params
    
    respond_to do |format|
      if @asset_type.save
        format.html { redirect_to [:directories, :asset_types], notice: "Asset type was successfully created." }
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
      if @asset_type.update(asset_type_params)
        format.html { redirect_to [:directories, :asset_types], notice: "Asset type was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset_type.destroy
    respond_to do |format|
      format.html { redirect_to [:directories, :asset_types], notice: "Asset type was successfully destroyed." }
    end
  end

private
  def asset_type_params
    params.fetch(:asset_type, {}).permit(:name, :parent_id)
  end

  def set_asset_type
    @asset_type = AssetType.find(params[:id])
  end
end 