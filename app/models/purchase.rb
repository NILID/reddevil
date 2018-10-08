class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :year

  has_many :columnships, dependent: :destroy
  has_many :deliveries,  dependent: :destroy
  has_many :columns,     through: :columnships

  accepts_nested_attributes_for :columnships
  accepts_nested_attributes_for :deliveries, allow_destroy: true

  after_create :build_columnships

  private

    def build_columnships
      self.year.columns.each do |c|
        self.columnships.create(column_id: c.id)
      end
    end
end
