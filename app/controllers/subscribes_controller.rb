class SubscribesController < ApplicationController
  load_and_authorize_resource except: %i[import favorites]

  def import
    Subscribe.destroy_all
    Subscribe.import(params[:file])
    redirect_to subscribes_url, notice: 'File imported'
  end

  def index
    @q = @subscribes.search(params[:q])
    @subscribes = @q.result(distinct: true).order(:fullname).page(params[:page]).per_page(25)
  end

  def favorites
    @subscribes = current_user.likees(Subscribe, sort: (:fullname))
    respond_to do |format|
      format.js
    end
  end

  def like
    current_user.toggle_like!(@subscribe)
    respond_to do |format|
      format.js
    end
  end

  def show; end
  def new;  end
  def edit; end

  def create
    respond_to do |format|
      if @subscribe.save
        format.html { redirect_to subscribes_url, notice: t('flash.was_created', item: Subscribe.model_name.human) }
        format.json { render json: @subscribe, status: :created, location: @subscribe }
      else
        format.html { render action: 'new' }
        format.json { render json: @subscribe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscribe.update_attributes(subscribe_params)
        format.html { redirect_to subscribes_url, notice: t('flash.was_updated', item: Subscribe.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscribe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscribe.destroy
    respond_to do |format|
      format.html { redirect_to subscribes_url, notice: t('flash.was_destroyed', item: Subscribe.model_name.human) }
      format.json { head :no_content }
    end
  end


  private
    def subscribe_params
      list_params_allowed = %i[departament email fullname phone_city phone_inter place position]
      params.require(:subscribe).permit(list_params_allowed)
    end
end
