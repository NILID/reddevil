class Subfile < ApplicationRecord
  belongs_to :substrate
  belongs_to :user

  has_attached_file :src,
        url: "/system/files/substrates/:substrate_id/:basename.:extension",
       path: ":rails_root/public/system/files/substrates/:substrate_id/:basename.:extension"

  validates :src, attachment_presence: true
  do_not_validate_attachment_file_type :src

  Paperclip.interpolates :substrate_id do |attachment, style|
    attachment.instance.substrate_id
  end
end
