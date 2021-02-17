class VacationsController < ApplicationController
  load_and_authorize_resource only: [:index]
  load_and_authorize_resource :member, except: [:index]
  load_and_authorize_resource :vacation, through: :member, except: [:index]

  layout 'user_with_side'

  def index; end

  def new
    @vacation.flag = params[:flag]
  end

  def list
    @vacations = @vacations.order(:startdate)
  end

  def create
    respond_to do |format|
      if @vacation.save
        format.html { redirect_to list_member_vacations_url(@member), notice: t('flash.was_created', item: Vacation.model_name.human) }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vacation.update_attributes(vacation_params)
        format.html { redirect_to list_member_vacations_url(@member), notice: t('flash.was_updated', item: Vacation.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'manage_holidays' }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vacation.destroy

    respond_to do |format|
      format.html { redirect_to list_member_vacations_url(@member), notice: t('flash.was_destroyed', item: Vacation.model_name.human) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def vacation_params
      params.require(:vacation).permit(:flag, :startdate, :enddate, :viceuser_id)
    end
end
