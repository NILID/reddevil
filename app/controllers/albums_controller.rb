class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource find_by: :slug

  def index
    @albums = @albums.order(:title).roots
    @new_songs = Song.includes(:album).order('created_at DESC').page(params[:page]).per_page(20)
    @q = Song.search(params[:q])
    if params[:q]
      @songs = @q.result(distinct: true).order(:file_file_name)
    end
  end

  def show
    @albums = @album.children.order(:title)
  end

  def download
    filename = @album.title
    temp_file = Tempfile.new(filename)
    begin
      Zip::OutputStream.open(temp_file) { |zos|  }
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
        @album.songs.each do |song|
          zipfile.add(Russian.translit(song.file_file_name), song.file.path) if song.file.exists?
        end
      end

      zip_data = File.read(temp_file.path)
      send_data(zip_data, type: 'application/zip', filename: filename + '.zip')
    ensure
      temp_file.close
      temp_file.unlink
    end
  end

  def favorites
    @songs = current_user.likees(Song)#.order(:created_at)
    @albums = current_user.likees(Album)
  end

  def like
    current_user.toggle_like!(@album)
    respond_to do |format|
      format.js
    end
  end

  def list
    @albums = @album.children.order(:title)
    @songs = @album.songs.order(:file_file_name)
    respond_to do |format|
      format.js
    end
  end

  def new
    @album.parent_id = params[:parent_id]
  end

  def edit
  end

  def create
    respond_to do |format|
      if @album.save
        if params[:songs]
          params[:songs].each { |song| @album.songs.create(file: song)}
        end

        format.html { redirect_to @album, notice: t('flash.was_created', item: Album.model_name.human) }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        if params[:songs]
          params[:songs].each { |song| @album.songs.create(file: song)}
        end

        format.html { redirect_to @album, notice: t('flash.was_updated', item: Album.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: t('flash.was_destroyed', item: Album.model_name.human) }
      format.json { head :no_content }
    end
  end
end
