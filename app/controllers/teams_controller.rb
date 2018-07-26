class TeamsController < ApplicationController
  layout 'main'

  load_and_authorize_resource

  def index
    @teams = @teams.order(:title).includes(:type)
  end

  def show; end
  def new;  end
  def edit; end

  def create
   respond_to do |format|
     if @team.save
       format.html { redirect_to teams_url, notice: t('flash.was_created', item: Team.model_name.human) }
       format.json { render json: @team, status: :created, location: @team }
     else
       format.html { render action: 'new' }
       format.json { render json: @team.errors, status: :unprocessable_entity }
     end
    end
  end

  def update
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: t('flash.was_updated', item: Team.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: t('flash.was_destroyed', item: Team.model_name.human) }
      format.json { head :no_content }
    end
  end
end
