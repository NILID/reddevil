class ResultsController < ApplicationController
  load_and_authorize_resource :user, except: :rebuild
  load_and_authorize_resource :result, through: :user, except: :rebuild
  load_and_authorize_resource only: :rebuild

  def new;  end
  def edit; end

  def counted
    respond_to do |format|
      if @result.update_attributes(total: @result.rebuild_total)
        format.js
      else
        format.js
      end
    end
  end

  def rebuild
    @round = Round.where(id: params[:round]).first
    @round.results.each do |r|
      r.update_attributes(total: r.rebuild_total)
    end
    @round.results.pluck(:user_id).uniq.each do |user_id|
      user = User.where(id: user_id).first
      user.profile.update_attributes(total_result: user.results.sum(:total))
    end

    (@round.forecasts.pluck(:user_id).uniq - @round.results.pluck(:user_id).uniq).each do |u|
      user = User.where(id: u).first
      r = user.results.create!(round_id: @round.id)
      r.update_attributes(total: r.rebuild_total)
    end
    render nothing: true
  end

  def create
    @result.total = @result.rebuild_total
    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: t('flash.was_created', item: Result.model_name.human) }
        format.js
        format.json { render json: @result, status: :created, location: @result }
      else
        format.html { render action: 'new' }
        format.js
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result.update_attributes(result_params)
        format.html { redirect_to @result, notice: t('flash.was_updated', item: Result.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @result.destroy

    respond_to do |format|
      format.html { redirect_to results_url, notice: t('flash.was_destroyed', item: Result.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def result_params
      list_params_allowed = %i[total round_id]
      params.require(:result).permit(list_params_allowed)
    end
end
