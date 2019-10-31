class MessagesController < ApplicationController
  load_and_authorize_resource

  layout 'withside'

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: t('flash.was_created', item: Message.model_name.human) }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update_attributes(message_params)
        format.html { redirect_to @message, notice: t('flash.was_updated', item: Message.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: t('flash.was_destroyed', item: Message.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def message_params
    list_params_allowed = %i[close content title]
    params.require(:message).permit(list_params_allowed)
  end
end
