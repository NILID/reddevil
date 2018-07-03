class WorksController < ApplicationController
  layout  'main'

  load_and_authorize_resource :art
  load_and_authorize_resource :work, through: :art

  def new
  end

  def edit
  end

  def create
    @work.user = current_user
    respond_to do |format|
      if @work.save
        format.html { redirect_to arts_url, notice: t('flash.was_created', item: Work.model_name.human) }
        format.json { render json: @work, status: :created, location: @work }
      else
        format.html { render action: 'new' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
     end
  end

  def update
    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to arts_url, notice: t('flash.was_updated', item: Work.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work.destroy

    respond_to do |format|
      format.html { redirect_to arts_url, notice: t('flash.was_destroyed', item: Work.model_name.human) }
      format.json { head :no_content }
    end
  end
end
