class SubstratesController < ApplicationController
  load_and_authorize_resource
  layout 'main'

  def index
    #@substrates =  @substrates.includes(:user)
    @q = @substrates.search(params[:q])
    @substrates = @q.result(distinct: true).includes(:user)
  end

  def show
  end

  def remote_show
    respond_to :js
  end

  def new
  end

  def edit
  end

  def create
    @substrate.user = current_user
    respond_to do |format|
      if @substrate.save
        format.html { redirect_to substrates_url, notice: t('substrates.was_created') }
        format.json { render json: @substrate, status: :created, location: @substrate }
      else
        format.html { render action: 'new' }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @substrate.update_attributes(params[:substrate])
        format.html { redirect_to substrates_url, notice: t('substrates.was_updated') }
        format.json { render json: @substrate }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@substrate) }
      end
    end
  end

  def destroy
    @substrate = Substrate.find(params[:id])
    @substrate.destroy

    respond_to do |format|
      format.html { redirect_to substrates_url }
      format.json { head :no_content }
    end
  end
end
