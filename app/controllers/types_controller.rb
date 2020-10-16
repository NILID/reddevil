class TypesController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @type.save
        format.html { redirect_to @type, notice: t('flash.was_created', item: Type.model_name.human) }
        format.json { render json: @type, status: :created, location: @type }
      else
        format.html { render action: 'new' }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @type.update_attributes(type_params)
        format.html { redirect_to @type, notice: t('flash.was_updated', item: Type.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @type.destroy

    respond_to do |format|
      format.html { redirect_to types_url, notice: t('flash.was_destroyed', item: Type.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def type_params
      list_params_allowed = %i[title]
      params.require(:type).permit(list_params_allowed)
    end
end
