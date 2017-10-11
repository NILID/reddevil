class Doc < ActiveRecord::Base
  attr_accessible :desc, :title, :file, :category_id

  belongs_to :category

  attr_reader :category_tokens

  has_attached_file :file,
      path: ":rails_root/public/system/docs/:attachment/:id/:style/:filename",
      url: "/system/docs/:attachment/:id/:style/:filename"
  validates :file, :attachment_presence => true
  validates :title, presence: true

  # def self.search(search)
  #   if search
  #     where('title LIKE ?', "%#{search}%")
  #   else
  #     scoped
  #   end
  # end
end
