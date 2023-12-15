class Accounting::NotesController < ApplicationController
  before_action :set_model, only: %i[create]
  before_action :set_note, only: %i[show update destroy]

  def index
    page_size = params[:per] || 10
    page = params[:page] || 0

    @notes = Note.reorder(date: :desc, created_at: :desc).page(page).per(page_size)
  end

  def create
    @note = Note.new(note_params)
    @note.noteble = @model
    @note.images.attach(params[:note][:images]) if params.dig(:note, :images).present? && @note.valid?

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
        @note.images.attach(params[:note][:images]) if params.dig(:note, :images).present?

        format.html { redirect_to @back_url, notice: "Note was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to @back_url, notice: "Note was successfully destroyed." }
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

  def set_back_url
    @back_url = if request.referer
      h = Rails.application.routes.recognize_path session[:back_url]
      h[:controller] == 'accounting/notes' ? session[:back_url] : [:accounting, set_note.noteble]
    else
      [:accounting, :notes]
    end
  end

  def note_params
    params.fetch(:note, {}).permit(:date, :text)
  end
end