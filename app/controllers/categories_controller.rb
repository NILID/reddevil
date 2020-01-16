class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :init_objects, only:   [:index, :manage]
  before_action :init_object,  except: [:index, :manage]

  def index
    @root_categories = @objects.specific.roots.order(:title)
  end

  def show; end
  def edit; end

  def new
    @object.parent_id = params[:parent_id]
  end

  def create
    respond_to do |format|
      if @object.save
        return_url = @object.class.name == 'Category' ? categories_url : @object
        format.html { redirect_to return_url, notice: t('flash.was_created', item: @object.model_name.human) }
        format.json { render json: @object, status: :created, location: @object }
      else
        format.html { render action: 'new' }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @object.update_attributes(category_params)
        return_url = @object.class.name == 'Category' ? categories_url : @object
        format.html { redirect_to return_url, notice: t('flash.was_updated', item: @object.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @object.destroy

    respond_to do |format|
      return_url = @object.class.name == 'Category' ? categories_url : manage_infocenter_categories_url
      format.html { redirect_to return_url, notice: t('flash.was_destroyed', item: @object.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def init_objects
    @objects = @categories
  end

  def init_object
    @object = @category
  end

  def category_params
    list_params_allowed = %i[ancestry title parent_id hidden flag position show_type]
    params.require(@object.class.name.underscore.to_sym).permit(list_params_allowed)
  end
end
