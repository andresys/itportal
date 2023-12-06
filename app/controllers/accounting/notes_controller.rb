class Accounting::NotesController < ApplicationController
  before_action :set_model, except: %i[index]
  before_action :set_note, only: %i[show update destroy]

  def index
    page_size = params[:per] || 10
    page = params[:page] || 0

    @notes = Note.page(page).per(page_size)
  end

  def create
    @note = Note.new(note_params)
    @note.noteble = @model

    respond_to do |format|
      if @note.save
        format.html { redirect_to [:accounting, @model], notice: "Note was successfully created." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def show
    render :edit
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to [:accounting, @model], notice: "Note was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to [:accounting, @model || :notes], notice: "Note was successfully destroyed." }
    end
  end

private

  def set_model
    @model = Asset.find(params[:asset_id]) if params[:asset_id]
    @model = Material.find(params[:material_id]) if params[:material_id]

    if params[:asset_id] || params[:material_id]
      raise "Model not found" unless @model
    end
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.fetch(:note, {}).permit(:date, :text)
  end
end