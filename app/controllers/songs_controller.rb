class SongsController < ApplicationController
  load_and_authorize_resource :album
  load_and_authorize_resource :song, through: :album

  def new
  end

  def download
    send_data @song.file.path, filename: @song.file_file_name
  end

  def create
    respond_to do |format|
      if @song.save
        format.html { redirect_to @album, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
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
      format.html { redirect_to @album }
      format.json { head :no_content }
    end
  end
end
