class Card < ApplicationRecord
  belongs_to :category
  has_one_attached :doc

  validates :title, presence: true
  validates :doc,   attached: true

  def preview(size: '400x400')
    return nil unless doc.attached? && doc.representable?
#    if doc.previewable?
#      doc.preview(resize: size).processed.service_url
#    else
#     doc.variant(resize: size).processed
#    end
#     doc.representation(crop: '400x400+0+0', resize: size).processed
     doc.representation(resize: size).processed
  end
end
