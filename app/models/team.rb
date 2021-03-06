class Team < ApplicationRecord
  belongs_to :type
  # belongs_to :first_teams, class_name: 'Match'

  has_attached_file :flag,
    styles: {thumb: {geometry: '100x100>'}},
    path: ":rails_root/public/system/teams/:attachment/:id/:style/:filename",
    url: "/system/teams/:attachment/:id/:style/:filename",
    default_url: "/default/flags/:style/missing.png"

  validates :title, presence: true

  validates_attachment :flag, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
end
