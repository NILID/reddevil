class Column < ApplicationRecord
  belongs_to :table
  belongs_to :row, optional: true

  after_create :build_columnships

  has_many :columnships, dependent: :destroy

  private

    def build_columnships
      self.table.rows.each do |p|
        p.columnships.create(column_id: self.id)
      end
    end
end
