class Row < ActiveRecord::Base
  belongs_to :user
  belongs_to :table

  has_many :columnships, dependent: :destroy, inverse_of: :row
  has_many :columns,     through: :columnships

  accepts_nested_attributes_for :columnships

  after_create :build_columnships

  private

    def build_columnships
      self.table.columns.each do |c|
        self.columnships.create(column_id: c.id)
      end
    end
end
