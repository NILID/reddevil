class ManufactureGroupsController < ApplicationController
  load_and_authorize_resource

  after_action  :touch_updated, only: %i[create]
  before_action :touch_updated, only: %i[actual]

  def new;    end
  def edit;   end
  def actual; end

  def create
    respond_to do |format|
      if @manufacture_group.save
        format.html { redirect_to Manufacture, notice: t('flash.was_created', item: ManufactureGroup.model_name.human) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @manufacture_group.update(manufacture_group_params)
        format.html { redirect_to Manufacture, notice: t('flash.was_updated', item: ManufactureGroup.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @manufacture_group.destroy
    respond_to do |format|
      format.html { redirect_to Manufacture, notice: t('flash.was_destroyed', item: ManufactureGroup.model_name.human) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def touch_updated
      @manufacture_group.touch_updated(current_user)
    end

    def manufacture_group_params
      manufacture_group_params = [:title, :contract, :actual, :limit_at, :without_contract,
                                  { manufactures_attributes: %i[id title priority material drawing multi _destroy] }]
      params.require(:manufacture_group).permit(manufacture_group_params)
    end
end
