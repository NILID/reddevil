class ColumnsController < ApplicationController
  load_and_authorize_resource :year
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
        format.html { redirect_to [@year, @column], notice: 'Column was successfully created.' }
        format.json { render json: @column, status: :created, location: @column }
      else
        format.html { render action: "new" }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @column.update_attributes(params[:column])
        format.html { redirect_to [@year, @column], notice: 'Column was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @column.destroy

    respond_to do |format|
      format.html { redirect_to [@year, Column] }
      format.json { head :no_content }
    end
  end
end
