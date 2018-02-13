# encoding: UTF-8

class RoundsController < ApplicationController

  load_and_authorize_resource
  layout 'main'

  def index
    @rounds = @rounds.order('created_at desc')
    # @users = User.order('total_result desc')
    tag = 'чмх2017'
    @users = (User.all.includes(:profile).map { |user, result| { user => Round.tagged_with(tag).map { |r| r.results.where(user_id: user).sum(:total) } } }).reduce(:merge)
    if @users
      @users = if params[:sort] == 'total'
        Hash[@users.sort_by{|k, v| k.profile.total_result}.reverse]
      elsif  params[:sort] == 'ratio'
        Hash[@users.sort_by{|k, v| k.ratio}.reverse]
      else
        Hash[@users.sort_by{|k, v| v}.reverse]
      end
    end
    # for test
    # Notification.new_round(User.where(email: 'dailyin@luch.podolsk.ru').first, Round.last).deliver_now
  end

  def show
    @users = User.includes(:profile).order('profiles.surname')
    @round_matches = @round.matches.includes([:team1, :team2])
  end

  def download
    @users = User.includes(:profile).order('profiles.surname')
    @round_matches = @round.matches.includes([:team1, :team2])
    respond_to do |format|
      format.pdf{ render pdf: @round.title, orientation: 'Landscape' }
    end
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

        # TODO
        # Move to model
        User.all.each { |user| Notification.new_round(user, @round).deliver_now }
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
