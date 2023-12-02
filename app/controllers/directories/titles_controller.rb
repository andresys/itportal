class Directories::TitlesController < DirectoriesController
  def index
    page_size = params[:per] || 10
    page = params[:page] || 0

    @titles = Title.page(page).per(page_size)
  end
end