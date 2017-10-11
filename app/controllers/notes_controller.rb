class NotesController < ApplicationController
  load_and_authorize_resource

  def index
    @notes_all_count=@notes.group(:status).count
    @q = @notes.search(params[:q])
    @notes = params[:q] ? @q.result(distinct: true) : @q.result(distinct: true).where(status: 'new')
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @note.save
        Notification.new_note(@note).deliver

        format.html { redirect_to notes_url, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to notes_url, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
