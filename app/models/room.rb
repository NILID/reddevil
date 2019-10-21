class Room < ApplicationRecord
  belongs_to :user
  has_many :room_messages, dependent: :destroy,
                          inverse_of: :room
  has_and_belongs_to_many :users

  validates :name, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
