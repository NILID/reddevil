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

  validates :title, presence: true
  validates :document, attached: true

  attr_reader :category_tokens

  def category_tokens=(tokens)
    self.category_ids = tokens
  end

  def category_tokens
    category_ids
  end

  private

  def clean_activities
    self.activities.destroy_all
  end

end
