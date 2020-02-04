class PagesController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    @pages = @pages.includes(:user)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @page.user = current_user
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: t('flash.was_created', item: Page.model_name.human) }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: t('flash.was_updated', item: Page.model_name.human) }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: t('flash.was_destroyed', item: Page.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def page_params
      params.require(:page).permit(:title, :content, :slug, :user_id)
    end
end
