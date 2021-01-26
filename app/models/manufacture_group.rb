class ManufactureGroup < ApplicationRecord

  after_create :create_multi_manufactures


  has_many :manufactures, dependent: :destroy
  validates :title, presence: true
  validates :contract,
            presence: true,
            if: -> { without_contract == false }

  accepts_nested_attributes_for :manufactures,
                reject_if: :all_blank,
            allow_destroy: true


  private
    def create_multi_manufactures
      self.manufactures.each do |manufacture|
        title = manufacture.title
        if manufacture.multi.to_i > 1
          manufacture.update_attribute(:title, (title + " № 1"))
          (manufacture.multi.to_i-1).times do |i|
            self.manufactures.create! title: title + " № #{i+2}",  priority: manufacture.priority, material: manufacture.material, drawing: manufacture.drawing
          end
        end
      end
    end
end
