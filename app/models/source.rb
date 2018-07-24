class Source < ActiveRecord::Base
  belongs_to :work
  attr_accessible :file, :hide

  has_attached_file :file,
    styles: {
      thumb: {geometry: '100x100#'},
      large: {geometry: '1200>'}
    },
    path: ":rails_root/public/system/sources/:attachment/:id/:style/:filename",
    url: "/system/sources/:attachment/:id/:style/:filename"

  validates :file, attachment_presence: true
end
