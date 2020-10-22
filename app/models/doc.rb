require 'open-uri'

class Doc < ApplicationRecord
  after_destroy :clean_activities

  include PublicActivity::Model
  tracked  :params => {
              :summary => proc { |controller, model| model.title }
           }

  has_many :categoryships, dependent: :destroy
  has_many :categories, through: :categoryships

  has_one_attached :document

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

  def grab_doc
    downloaded_image = open('http://localhost:3000/' + self.file.url)
    self.document.attach(io: downloaded_image  , filename: self.file_file_name)
  end

  private

  def clean_activities
    self.activities.destroy_all
  end

end
