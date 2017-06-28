class ArtsController < ApplicationController
  layout  'main'
  load_and_authorize_resource


  def index
    @dima = User.where(id: 1)
    @ilya = User.where(id: 2)
    @arts = @arts.order('deadline desc').paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @art.save
        format.html { redirect_to arts_url, notice: t('art.was_created') }
        format.json { render json: @art, status: :created, location: @art }
      else
        format.html { render action: "new" }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @art.update_attributes(params[:art])
        format.html { redirect_to arts_url, notice: t('art.was_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @art.destroy

    respond_to do |format|
      format.html { redirect_to arts_url }
      format.json { head :no_content }
    end
  end

end
