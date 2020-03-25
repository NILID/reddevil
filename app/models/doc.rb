class Doc < ApplicationRecord
  has_many :categoryships, dependent: :destroy
  has_many :categories, through: :categoryships

  has_attached_file :file,
      path: ":rails_root/public/system/docs/:attachment/:id/:style/:filename",
      url: "/system/docs/:attachment/:id/:style/:filename"

  validates :title, presence: true
  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file

  attr_reader :category_tokens

  def category_tokens=(tokens)
    self.category_ids = tokens
  end

  def category_tokens
    category_ids
  end

  # def self.search(search)
  #   if search
  #     where('title LIKE ?', "%#{search}%")
  #   else
  #     scoped
  #   end
  # end
end
