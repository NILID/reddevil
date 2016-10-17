class TempusersController < ApplicationController
  load_and_authorize_resource

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
      if @tempuser.save
        format.html { redirect_to @tempuser, notice: 'Tempuser was successfully created.' }
        format.json { render json: @tempuser, status: :created, location: @tempuser }
      else
        format.html { render action: "new" }
        format.json { render json: @tempuser.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tempuser.update_attributes(params[:tempuser])
        format.html { redirect_to @tempuser, notice: 'Tempuser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tempuser.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tempuser.destroy

    respond_to do |format|
      format.html { redirect_to tempusers_url }
      format.json { head :no_content }
    end
  end
end
