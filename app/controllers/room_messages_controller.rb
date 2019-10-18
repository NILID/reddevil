class RoomMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entities

  def create
    @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                    message: params.dig(:room_message, :message)
    if @room_message.save
      RoomChannel.broadcast_to @room, @room_message
      render body: nil
    else
      render body: nil, status: :fail
    end
  end


  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
