class Directories::MolsController < DirectoriesController
  def index
    @mols = Mol.where({}).page(params[:page])
  end

  def new
  end

  def create
  end
end