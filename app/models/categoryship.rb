class Categoryship < ActiveRecord::Base
  belongs_to :category
  belongs_to :doc
end
