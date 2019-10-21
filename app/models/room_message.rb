class RoomMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room, inverse_of: :room_messages

  def as_json(options)
    super(options).merge(user_avatar_url: user.avatar_url, user_surname_name: user.surname_name)
  end

  validates :message, presence: true
end
