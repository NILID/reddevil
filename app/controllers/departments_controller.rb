class DepartmentsController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index; end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, notice: t('flash.was_created', item: Dataset.model_name.human) }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, notice: t('flash.was_updated', item: Dataset.model_name.human) }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: t('flash.was_destroyed', item: Dataset.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def department_params
      params.require(:department).permit(:title)
    end
end
