class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :year
  attr_accessible :user_id, :erp, :analytic, :aztz, :bidding, :committee, :conclusion_expert, :conclusion_pdtk, :contract, :contract_project, :contract_request, :delivery, :doc, :kp, :nmc, :prepay_date, :prepay_sum, :price, :provider, :proxy, :request, :startdate, :title, :warmth_date, :warmth_sum, :zkpdate, :zsc_kp
end
