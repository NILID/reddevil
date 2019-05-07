class ForecastsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :forecast, through: :user

  def new
    @match = Match.where(id: params[:match_id] ? params[:match_id] : @forecast.match_id).first
    respond_to do |format|
      format.js
    end
  end

  def edit
    @match = @forecast.match
    respond_to do |format|
      format.js
    end
  end

  def create
    @match = Match.where(id: params[:match_id] ? params[:match_id] : @forecast.match_id).first
    respond_to do |format|
      if @forecast.save
        update_count
        format.js
      else
        format.js { render 'errors', locals: { object: @forecast} }
      end
    end
  end

  def update
    @match = Match.where(id: @forecast.match_id).first
    respond_to do |format|
      if @forecast.update_attributes(forecast_params)
        format.js
      else
        format.js { render 'errors', locals: { object: @forecast} }
      end
    end
  end

  def destroy
    @forecast.destroy

    respond_to do |format|
      update_count
      format.html { redirect_to round_path(@forecast.round), notice: t('flash.was_destroyed', item: Forecast.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

    def update_count
      user = @forecast.user
      user.forecasts_count = user.forecasts.count
      user.save!
    end

    def forecast_params
      list_params_allowed = %i[team1goal team2goal match_id winner_id ending]
      params.require(:forecast).permit(list_params_allowed)
    end
end
