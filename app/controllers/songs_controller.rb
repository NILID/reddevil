class SongsController < ApplicationController
  load_and_authorize_resource :album, find_by: :slug
  load_and_authorize_resource :song, through: :album

  layout 'withside'

  def new; end

  def download
    send_data @song.file.path, filename: @song.file_file_name
  end

  def create
    respond_to do |format|
      if @song.save
        format.html { redirect_to @album, notice: t('flash.was_created', item: Song.model_name.human) }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: 'new' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    current_user.toggle_like!(@song)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to @album, notice: t('flash.was_destroyed', item: Song.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def song_params
      list_params_allowed = %i[file title]
      params.require(:song).permit(list_params_allowed)
    end
end
