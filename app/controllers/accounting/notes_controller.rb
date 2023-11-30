class Accounting::NotesController < ApplicationController
  before_action :set_model

  def create
    @note = Note.new(note_params)
    @note.noteble = @model

    respond_to do |format|
      if @note.save
        format.html { redirect_to [:accounting, @model], notice: "Note was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end

  end

private

  def set_model
    @model = Asset.find(params[:asset_id]) if params[:asset_id]
    @model = Material.find(params[:material_id]) if params[:material_id]

    raise "Model not found" unless @model
  end

  def note_params
    params.fetch(:note, {}).permit(:date, :text)
  end
end