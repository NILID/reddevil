class MaterialsController < ApplicationController
  load_and_authorize_resource :material

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: t('flash.was_created', item: Material.model_name.human) }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { render action: 'new' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @material.update_attributes(params[:material])
        format.html { redirect_to @material, notice: t('flash.was_updated', item: Material.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @material.destroy

    respond_to do |format|
      format.html { redirect_to materials_url, notice: t('flash.was_destroyed', item: Material.model_name.human) }
      format.json { head :no_content }
    end
  end
end
