class ForecastsController < ApplicationController
  load_and_authorize_resource :tempuser
  load_and_authorize_resource :forecast, through: :tempuser

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @forecast.save
        format.html { redirect_to round_path(@forecast.match.round), notice: t('forecasts.was_created') }
        format.json { render json: @forecast, status: :created, location: @forecast }
      else
        format.html { render action: 'new' }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @forecast.update_attributes(params[:forecast])
        format.html { redirect_to round_path(@forecast.match.round), notice: t('forecasts.was_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', match_id: @forecast.match_id }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forecast.destroy

    respond_to do |format|
      format.html { redirect_to round_path(@forecast.match.round) }
      format.json { head :no_content }
    end
  end
end
