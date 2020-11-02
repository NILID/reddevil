class NotesController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index
    @notes_all_count = @notes.group(:status).count
    @q = @notes.ransack(params[:q])
    @notes = params[:q] ? @q.result(distinct: true).includes(:user) : @q.result(distinct: true).where(status: 'new').includes(:user)
  end

  def new;  end
  def edit; end

  def create
    @note.user = current_user || nil
    respond_to do |format|
      if @note.save
        Notification.new_note(@note).deliver_now
        path = current_user ? notes_url : root_url

        format.html { redirect_to path, notice: t('flash.was_created', item: Note.model_name.human) }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update_attributes(note_params)
        format.html { redirect_to notes_url, notice: t('flash.was_updated', item: Note.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: t('flash.was_destroyed', item: Note.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

    def note_params
      list_params_allowed = %i[content screenshot]
      list_params_allowed << %i[status review] if (current_user&.role? :admin)
      params.require(:note).permit(list_params_allowed)
    end
end
