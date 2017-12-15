class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :year

  has_many :columnships, dependent: :destroy
  has_many :columns, through: :columnships
  has_many :deliveries, dependent: :destroy

  accepts_nested_attributes_for :columnships
  accepts_nested_attributes_for :deliveries, allow_destroy: true

  attr_accessible :user_id, :erp, :analytic, :aztz, :bidding, :committee, :conclusion_expert, :conclusion_pdtk,
   :contract, :contract_project, :contract_request, :delivery, :doc, :kp, :nmc, :prepay_date, :prepay_sum,
   :price, :provider, :proxy, :request, :startdate, :title, :warmth_date, :warmth_sum, :zkpdate, :zsc_kp,
   :status, :status_color,
   :columnships_attributes, :deliveries_attributes

  attr_accessor :rorder

  after_create :build_columnships

  private

    def build_columnships
      self.year.columns.each do |c|
        self.columnships.create(column_id: c.id)
      end
    end
end
