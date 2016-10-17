class TeamsController < ApplicationController
  layout "main"

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
     if @team.save
         format.html { redirect_to teams_url, notice: 'Team was successfully created.' }
         format.json { render json: @team, status: :created, location: @team }
    else
         format.html { render action: "new" }
         format.json { render json: @team.errors, status: :unprocessable_entity }
     end
    end
  end

  def update
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
