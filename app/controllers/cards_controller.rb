class CardsController < ApplicationController
  load_and_authorize_resource :infocenter_category
  load_and_authorize_resource :card, through: :infocenter_category

  layout 'user'

  def new;  end
  def edit; end

  def create
    respond_to do |format|
      if @card.save
        format.html { redirect_to @infocenter_category, notice: t('flash.was_created', item: Card.model_name.human) }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @infocenter_category, notice: t('flash.was_updated', item: Card.model_name.human) }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to @infocenter_category, notice: t('flash.was_destroyed', item: Card.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def card_params
      params.require(:card).permit(:title, :doc)
    end
end
