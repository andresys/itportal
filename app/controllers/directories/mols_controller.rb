class Directories::MolsController < DirectoriesController
  before_action :set_mol, only: %i[show update destroy]
  before_action { authorize(@mol || Mol) }

  def index
    @mols = Mol.page(page).per(page_size)
  end

  def new
  end

  def create
  end

  private

  def set_mol
    @mol = Mol.find(params[:id])
  end
end