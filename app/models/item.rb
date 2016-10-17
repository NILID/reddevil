class Item < ActiveRecord::Base
  attr_accessible :file

  has_attached_file :file,
     url: "/system/items/:id/:basename.:extension",
     path: ":rails_root/public/system/items/:id/:basename.:extension"

  validates_attachment :file, content_type: {content_type: ["text/plain"]}, size: {less_than: 1.megabytes}

  validates_attachment_presence :file

end
