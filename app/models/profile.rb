class Profile < ApplicationRecord
  belongs_to :user

  has_attached_file :avatar,
    styles: {
        thumb:  { geometry: '50x50#' },
        medium: { geometry: '100x100#' },
        large:  { geometry: '200x200#' }
    },
    processors: [:cropper],
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename",
    default_url: "/default/avatars/:style/missing.jpg"

  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  # for crop
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
end
