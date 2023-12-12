class Directories::MolsController < DirectoriesController
  def index
    page_size = params[:per] || 10
    page = params[:page] || 0

    @mols = Mol.page(page).per(page_size)
  end

  def new
  end

  def create
  end
end