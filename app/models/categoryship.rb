class Categoryship < ActiveRecord::Base
  attr_accessible :category_id, :doc_id

  belongs_to :category
  belongs_to :doc
end
