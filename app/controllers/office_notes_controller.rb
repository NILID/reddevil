class OfficeNotesController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index
    @office_notes = @office_notes.order(:created_at)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf{ render pdf: 'Members' }
    end
  end

  def new;  end
  def edit; end

  def create
    @office_note.user = current_user
    respond_to do |format|
      if @office_note.save
        format.html { redirect_to office_notes_url, notice: t('flash.was_created', item: OfficeNote.model_name.human) }

        format.json { render :show, status: :created, location: @office_note }
      else
        format.html { render :new }
        format.json { render json: @office_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_document
    @document = ActiveStorage::Blob.find_signed(params[:document_id])
    # Check valid method to destroy attachment
    @document.attachments.first.purge

    redirect_to @office_note
  end

  def update
    respond_to do |format|
      if @office_note.update(office_note_params)
        format.html { redirect_to @office_note, notice: t('flash.was_updated', item: OfficeNote.model_name.human) }
        format.json { render :show, status: :ok, location: @office_note }
      else
        format.html { render :edit }
        format.json { render json: @office_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office_note.destroy
    respond_to do |format|
      format.html { redirect_to office_notes_url, notice: t('flash.was_destroyed', item: OfficeNote.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def office_note_params
      params.require(:office_note).permit(:num, :title, :whom, :created_at, documents: [])
    end
end
