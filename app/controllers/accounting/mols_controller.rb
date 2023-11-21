class Accounting::MolsController < ApplicationController
  def index
    @mols = Mol.where({}).page(params[:page])
  end
end