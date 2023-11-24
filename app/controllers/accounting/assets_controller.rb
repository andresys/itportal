class Accounting::AssetsController < ApplicationController
  before_action :set_asset, only: %i[show edit update destroy print]
  before_action :set_back_url, :only => :index

  layout "sticker", :only => :print
  layout false, :only => [:new, :edit]

  # GET /accounting/assets or /accounting/assets.json
  def index
    asset = Asset.arel_table
    matches_string =  ->(p){ asset[p].matches("%#{params[:q]}%") }

    @query = request.query_parameters
    @statuses = Asset.statuses.merge('all' => -1)
    @status = @statuses[params[:status]] && params[:status] || 'on_balance'

    @mol = Mol.find_by_id(params[:mol] ||= nil)
    @location = Location.find_by_id(params[:location])

    query_parameters = {}

    if @status
      accounts = { 'on_balance' => ["101.36", "101.34"], 'out_balance' => ["21.36", "21.34"], 'storage' => ["102"] }
      accounts = accounts[@status]
      query_parameters.merge!(account: {code: accounts}) if accounts&.any?
    end

    if @mol
      query_parameters.merge!(mol: {id: @mol})
    end

    if @location
      query_parameters.merge!(location: {id: @location})
    end

    page_size = params[:per] || 10
    page = params[:page] || 0

    @assets = Asset.left_joins(:uids, :images_attachments).joins(:account, :mol, :location)
      .where(query_parameters)
      .where(matches_string.(:name).or(matches_string.(:inventory_number)))
      .group(:id)
    
    @assets = @assets.having("COUNT(active_storage_attachments) > 0") if params[:photo] == 1.to_s
    @assets = @assets.having("COUNT(active_storage_attachments) = 0") if params[:photo] == 2.to_s
    
    @assets = @assets.page(page).per(page_size)
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
        format.html { redirect_to [:accounting, @asset], notice: "Asset was successfully created." }
        format.json { render :show, status: :created, location: [:accounting, @asset] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounting/assets/1 or /accounting/assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        @asset.images.attach(params[:asset][:images]) if params.dig(:asset, :images).present?

        format.html { redirect_to [:accounting, @asset], notice: "Asset was successfully updated." }
        format.json { render :show, status: :ok, location: [:accounting, @asset] }
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
      format.html { redirect_to [:accounting, @asset], notice: "Asset was successfully destroyed." }
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

  def import
    @job = ImportAssetsFrom1cJob.perform_later
    respond_to do |format|
      format.html { redirect_to accounting_assets_path, notice: "Run job: import assets from 1c." }
      # format.html { redirect_to job_path(@job.job_id), notice: "Run job: import assets from 1c." }
      format.json { render show: @job, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      ids = params[:ids] && JSON.parse(params[:ids]) || params[:id]
      @asset = ids.kind_of?(Array) && ids.map{|id| Asset.find(id)} || Asset.find(ids)
    end

    def set_back_url
      session[:back_url] = request.url
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.fetch(:asset, {}).permit(:name, :description, :cost, :date, :status, :inventory_number)
    end
end
