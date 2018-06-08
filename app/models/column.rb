class Column < ActiveRecord::Base
  belongs_to :year
  belongs_to :purchase

  after_create :build_columnships

  has_many :columnships, dependent: :destroy

  private

    def build_columnships
      self.year.purchases.each do |p|
        p.columnships.create(column_id: self.id)
      end
    end
end
