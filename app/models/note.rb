class Note < ActiveRecord::Base
  attr_accessible :content, :status, :review, :screenshot

  STATUS = %w(new failed done later)

  has_attached_file :screenshot, styles: { medium: '800x600>', thumb: '100x100>' },
      path: ":rails_root/public/system/:attachment/:id/:style/:filename",
      url: "/system/:attachment/:id/:style/:filename"

  validates :content, presence: true
  validates_attachment :screenshot, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] },
                                    size: { in: 0..10.megabytes }

end
