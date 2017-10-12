class Doc < ActiveRecord::Base
  attr_accessible :desc, :title, :file, :category_id

  belongs_to :category

  attr_reader :category_tokens

  has_attached_file :file,
      path: ":rails_root/public/system/docs/:attachment/:id/:style/:filename",
      url: "/system/docs/:attachment/:id/:style/:filename"

  validates :title, presence: true
  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file

  # def self.search(search)
  #   if search
  #     where('title LIKE ?', "%#{search}%")
  #   else
  #     scoped
  #   end
  # end
end
