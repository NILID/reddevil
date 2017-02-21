class FoldersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :folder, through: :user

  def index
    @folders = @folders.roots.order(:title)
  end

  def show
    @folder_children = @folder.children.order(:title)
    @folder_datasets = @folder.datasets.order(:title)
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @folder.save
        format.html { redirect_to [@user, @folder], notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        format.html { render action: "new", locals: {parent_id: params[:parent_id]} }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to [@user, @folder], notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to [@user, Folder] }
      format.json { head :no_content }
    end
  end
end
