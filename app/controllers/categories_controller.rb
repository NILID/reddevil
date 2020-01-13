class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @root_categories = @categories.roots.order(:title)
  end

  def show; end
  def edit; end

  def new
    @category.parent_id = params[:parent_id]
  end

  def create
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: t('flash.was_created', item: Category.model_name.human) }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @category.update_attributes(category_params)
        format.html { redirect_to categories_url, notice: t('flash.was_updated', item: Category.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: t('flash.was_destroyed', item: Category.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def category_params
    list_params_allowed = %i[ancestry title parent_id :hidden]
    params.require(:category).permit(list_params_allowed)
  end
end
