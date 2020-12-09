class ManufacturesController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @manufacture.save
        format.html { redirect_to @manufacture, notice: t('flash.was_created', item: Manufacture.model_name.human) }
        format.json { render :show, status: :created, location: @manufacture }
      else
        format.html { render :new }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manufacture.update(manufacture_params)
        format.html { redirect_to @manufacture, notice: t('flash.was_updated', item: Manufacture.model_name.human) }
        format.json { render :show, status: :ok, location: @manufacture }
      else
        format.html { render :edit }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manufacture.destroy
    respond_to do |format|
      format.html { redirect_to manufactures_url, notice: t('flash.was_destroyed', item: Manufacture.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def manufacture_params
      manufacture_params = [:title, :drawing, :contract, :material, :user, :machine, :operation, :otk, :priority]
      manufacture_params << [:otk] if (current_user&.role? :admin) || (current_user&.has_group? :otk)
      params.require(:manufacture).permit(manufacture_params)
    end
end
