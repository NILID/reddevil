class RoomsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities

  def index; end

  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(user: [:profile])
  end

  def new
  end

  def create
    if @room.save
      flash[:success] = t('flash.was_created', item: Room.model_name.human)
      redirect_to rooms_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(room_params)
      flash[:success] = t('flash.was_updated', item: Room.model_name.human)
      redirect_to rooms_path
    else
      render :new
    end
  end

  protected

  def load_entities
    @rooms = Room.order(created_at: :desc)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
