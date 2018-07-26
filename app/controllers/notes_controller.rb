class NotesController < ApplicationController
  load_and_authorize_resource

  layout 'main', except: 'index'

  def index
    @notes_all_count = @notes.group(:status).count
    @q = @notes.search(params[:q])
    @notes = params[:q] ? @q.result(distinct: true).includes(:user) : @q.result(distinct: true).where(status: 'new').includes(:user)
  end

  def new;  end
  def edit; end

  def create
    @note.user = current_user || nil
    respond_to do |format|
      if @note.save
        Notification.new_note(@note).deliver_now

        format.html { redirect_to notes_url, notice: t('flash.was_created', item: Note.model_name.human) }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update_attributes(params[:note])
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
end
