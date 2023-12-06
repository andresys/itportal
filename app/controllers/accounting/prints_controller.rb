class Accounting::PrintsController < ApplicationController
  layout "sticker", :only => :print

  def index
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
end