# encoding: UTF-8

class RoundsController < ApplicationController

  load_and_authorize_resource
  layout 'main'

  before_action :get_teams, only: %i[new edit create update]

  def index
    @rounds = @rounds.order('created_at desc')
    @rounds_finished = @rounds.finished.pluck(:id)
    @forecasts = Forecast.all
    @matches = Match.all
    @match_finished = @matches.where(round_id: @rounds_finished).pluck(:id)
    @forecasts_finished = @forecasts.where(match_id: @match_finished).pluck(:id)

    # @users = User.order('total_result desc')
    # tag = 'ои2018'
    # tag = 'чмх2017'
    # tag = 'чмх2018'
    # tag = 'чмф2018'
    tag = 'чмx2019'
    @all_users = User.where(sport_flag: true)
    @users = (@all_users.includes(:profile).map { |user| { user => Round.tagged_with(tag).map { |r| r.results.where(user_id: user).sum(:total) }.sum } }).reduce(:merge)
    if @users
      @users = if params[:sort] == 'total'
        Hash[@users.sort_by{ |k, v| k.profile.total_result }.reverse]
      elsif params[:sort] == 'win'
        Hash[@users.sort_by{ |k, v| k.win_forecasts_count }.reverse]
      elsif params[:sort] == 'ratio'
        Hash[@users.sort_by{ |k, v| k.ratio(@match_finished, @all_users)[:ratio_count] }.reverse]
      elsif params[:sort] == 'new_ratio'
        Hash[@users.sort_by{ |k, v| k.ratio(@match_finished, @all_users)[:new_ratio] }.reverse]
      else
        Hash[@users.sort_by{|k, v| v}.reverse]
      end
    end
    # for test
    # Notification.new_round(User.where(email: 'dailyin@luch.podolsk.ru').first, Round.last).deliver_now
  end

  def show
    @users = User.where(sport_flag: true).includes(:profile).order('profiles.surname')
    @round_matches = @round.matches.includes([:team1, :team2])
  end

  def download
    @users = User.includes(:profile).order('profiles.surname')
    @round_matches = @round.matches.includes([:team1, :team2])
    respond_to do |format|
      format.pdf{ render pdf: @round.title, orientation: 'Landscape' }
    end
  end

  def new;  end
  def edit; end

  def create
    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: t('flash.was_created', item: Round.model_name.human) }
        format.json { render json: @round, status: :created, location: @round }

        # TODO
        # Move to model
        User.where(sport_flag: true).all.each { |user| Notification.new_round(user, @round).deliver_now }
      else
        format.html { render action: 'new' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @round.update_attributes(round_params)
        format.html { redirect_to @round, notice: t('flash.was_updated', item: Round.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url, notice: t('flash.was_destroyed', item: Round.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def get_teams
    @teams = Team.order(:title)
  end

  def round_params
    list_params_allowed = [
                            :close,
                            :content,
                            :title,
                            :deadline,
                            :type_id,
                            :tag_list,
                            :empty_match,
                            :draw,
                            { :matches_attributes => %i[id team1goal team2goal team1_id team2_id winner_id ending desc _destroy] }
                          ]

    params.require(:round).permit(list_params_allowed)
  end
end
