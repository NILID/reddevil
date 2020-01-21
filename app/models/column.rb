class Column < ActiveRecord::Base
  belongs_to :table
  belongs_to :purchase, optional: true

  after_create :build_columnships

  has_many :columnships, dependent: :destroy

  private

    def build_columnships
      self.table.purchases.each do |p|
        p.columnships.create(column_id: self.id)
      end
    end
end
