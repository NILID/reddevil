class DatasetsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :folder
  load_and_authorize_resource :dataset, through: :folder


  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @dataset.user=current_user
    respond_to do |format|
      if @dataset.save
        format.html { redirect_to [@user, @folder], notice: 'Dataset was successfully created.' }
        format.json { render json: @dataset, status: :created, location: @dataset }
      else
        format.html { render action: "new" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dataset.update_attributes(params[:dataset])
        format.html { redirect_to [@user, @folder], notice: 'Dataset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to [@user, @folder] }
      format.json { head :no_content }
    end
  end
end
