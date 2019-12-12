class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'users-online'
  end
end
