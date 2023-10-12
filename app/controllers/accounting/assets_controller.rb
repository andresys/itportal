class Accounting::AssetsController < ApplicationController
  before_action :set_asset, only: %i[ show edit update destroy print]

  layout "sticker", :only => :print

  # GET /accounting/assets or /accounting/assets.json
  def index
    @assets = Asset.where({}).page(params[:page])
  end

  # GET /accounting/assets/1 or /accounting/assets/1.json
  def show
  end

  # GET /accounting/assets/new
  def new
    @asset = Asset.new
  end

  # GET /accounting/assets/1/edit
  def edit
  end

  # POST /accounting/assets or /accounting/assets.json
  def create
    @asset = Asset.new(asset_params)

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: "Asset was successfully created." }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounting/assets/1 or /accounting/assets/1.json
  def update
    respond_to do |format|
      if @asset.update(accounting_item_params)
        format.html { redirect_to @asset, notice: "Asset was successfully updated." }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounting/assets/1 or /accounting/assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: "Asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def print

    # uri = URI('http://192.168.10.102/stickerprint2.php')
    # http = Net::HTTP.new(uri.host)
    # request = Net::HTTP::Post.new(uri.request_uri)
    # request.body = render_to_string 'print', layout: nil
    # res = http.request(request)

    # render json: {status: defined?(res) && res && res.body || "error"}
    # render html: render_to_string('print', layout: nil)
    respond_to do |format|
      format.html
      format.pdf do
        t = Tempfile.new('sticker', encoding: 'ascii-8bit')
        begin
          t.write(render_to_string  pdf: "sticker", template: 'assets/print.html.erb', margin: {top: 4, bottom: 0, left: 2, right: 2}, page_width: 58, page_height: 60, zoom: 1.1)
          t.close
          printer = CupsPrinter.new("Zebra-GK420D", :hostname => '172.30.6.7')
          printer.print_file(t.path)
        ensure
          t.delete
        end
        # pdf = render_to_string  pdf: "sticker", template: 'assets/print.html.erb', margin: {top: 4, bottom: 0, left: 2, right: 2}, page_width: 58, page_height: 60, zoom: 1.1
        render pdf: "sticker", template: 'assets/print.html.erb', margin: {top: 4, bottom: 0, left: 2, right: 2}, page_width: 58, page_height: 60, zoom: 1.1
      end
    end
  end

  def print2
    uri = URI('http://172.30.6.233/stickerprint2.php')
    @items.each do |item|
      @item = item
      @type = :small

      http = Net::HTTP.new(uri.host)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = render_to_string 'print', layout: nil
      res = http.request(request)
    end
    render json: {status: defined?(res) && res && res.body || "error"}
    #respond_to do |format|
    #  format.html { redirect_to items_url, notice: 'Item was successfully marked to print.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
      @asset = ids.kind_of?(Array) && ids.map{|id| Asset.find(id)} || Asset.find(ids)
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.fetch(:asset, {}).permit(:name, :description, :inventory_number)
    end
end
