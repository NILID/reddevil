# encoding: UTF-8

class RoundsController < ApplicationController

  load_and_authorize_resource
  layout 'main'

  def index
    @rounds = @rounds.order('created_at desc')
    # @tempusers = Tempuser.order('total_result desc')
    tag = 'чмх2017'
    @tempusers = (Tempuser.all.map {|t, result| {t => Round.tagged_with(tag).sum { |r| r.results.where(tempuser_id: t).sum(:total) }}}.reduce(:merge))
    @tempusers = if params[:sort] == 'total'
      Hash[@tempusers.sort_by{|k, v| k.total_result}.reverse]
    else
      Hash[@tempusers.sort_by{|k, v| v}.reverse]
    end
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
