class Accounting::NotesController < AccountingController
  before_action :set_accounting, only: %i[create]
  before_action :set_note, only: %i[edit update destroy]
  before_action { authorize(@note || Note) }

  def index
    @notes = Note.reorder(date: :desc, created_at: :desc).page(page).per(page_size)
  end

  def create
    @note = @accounting.notes.build note_params
    @note.images.attach(params[:note][:images]) if params.dig(:note, :images).present? && @note.valid?

    respond_to do |format|
      if @note.save
        format.html { redirect_to [:accounting, @accounting], notice: "Note was successfully created." }
        format.turbo_stream { @note = Note.new(date: Date.current)  }
      else
        format.html { render "accounting/#{@accounting.class.name.underscore}s/show", status: :unprocessable_entity }
      end
    end
  end

  def edit
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
  def set_accounting
    @accounting = Asset.find(params[:asset_id]) if params[:asset_id]
    @accounting = Material.find(params[:material_id]) if params[:material_id]
    @accounting
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def set_back_url
    @back_url = if request.referer
      h = Rails.application.routes.recognize_path session[:back_url]
      h[:controller] == 'accounting/notes' ? session[:back_url] : [:accounting, set_accounting || set_note.noteble]
    else
      [:accounting, :notes]
    end
  end

  def note_params
    params.fetch(:note, {}).permit(:date, :text)
  end
end