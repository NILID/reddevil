class SubstratesController < ApplicationController
  load_and_authorize_resource

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    @substrate.user = current_user

    respond_to do |format|
      if @substrate.save
        format.html { redirect_to @substrate, notice: t('flash.was_created', item: Substrate.model_name.human) }
        format.json { render :show, status: :created, location: @substrate }
      else
        format.html { render :new }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @substrate.update(substrate_params)
        format.html { redirect_to @substrate, notice: t('flash.was_updated', item: Substrate.model_name.human) }
        format.json { render :show, status: :ok, location: @substrate }
      else
        format.html { render :edit }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @substrate.destroy
    respond_to do |format|
      format.html { redirect_to substrates_url, notice: t('flash.was_destroyed', item: Substrate.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def substrate_params
      params.require(:substrate).permit(:drawing, :detail, :amount, :contract, :arrival_at, :arrival_from, :shipping_at, :shipping_to, :shipping_base, :status, :user_id)
    end
end
