class RoundsController < ApplicationController

  load_and_authorize_resource
  layout "main", except: [:index]

  def index
    @rounds = @rounds.order('created_at desc')
    @profiles = Profile.order('total_result desc')
  end

  def show
    @tempusers = Tempuser.order(:username).includes(:user)
    @round_matches = @round.matches.includes([:team1, :team2])
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "new" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url }
      format.json { head :no_content }
    end
  end
end
