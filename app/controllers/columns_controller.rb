class ColumnsController < ApplicationController
  load_and_authorize_resource :year, find_by: :slug
  load_and_authorize_resource :column, through: :year

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
      if @column.save
        format.html { redirect_to [@year, @column], notice: t('flash.was_created', item: Column.model_name.human) }
        format.json { render json: @column, status: :created, location: @column }
      else
        format.html { render action: 'new' }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @column.update_attributes(column_params)
        format.html { redirect_to [@year, @column], notice: t('flash.was_updated', item: Column.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @column.destroy

    respond_to do |format|
      format.html { redirect_to [@year, Column], notice: t('flash.was_destroyed', item: Column.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def column_params
    params.require(:column).permit(:name, :column_type)
  end
end
