class MatchesController < ApplicationController
  load_and_authorize_resource :round
  load_and_authorize_resource :match, through: :round

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
      if @match.save
        format.html { redirect_to [@round, @match], notice: 'Match was successfully created.' }
        format.json { render json: @match, status: :created, location: @match }
      else
        format.html { render action: "new" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to [@round, @match], notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to [@round, Match] }
      format.json { head :no_content }
    end
  end
end
