class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

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
      if @message.update_attributes(params[:message])
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
end
