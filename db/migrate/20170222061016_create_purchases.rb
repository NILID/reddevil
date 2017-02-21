class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :title
      t.float :price
      t.string :provider
      t.string :doc
      t.references :user
      t.date :startdate, default: nil
      t.date :zkpdate, default: nil
      t.date :kp, default: nil
      t.date :zsc_kp, default: nil
      t.date :nmc, default: nil
      t.date :aztz, default: nil
      t.date :conclusion_expert, default: nil
      t.date :analytic, default: nil
      t.date :conclusion_pdtk, default: nil
      t.date :erp, default: nil
      t.date :request, default: nil
      t.date :bidding, default: nil
      t.date :committee, default: nil
      t.date :contract_request, default: nil
      t.date :contract_project, default: nil
      t.date :contract, default: nil
      t.date :prepay_date, default: nil
      t.integer :prepay_sum
      t.date :warmth_date, default: nil
      t.integer :warmth_sum
      t.date :proxy, default: nil
      t.date :delivery, default: nil
      t.references :year
    end
    add_index :purchases, :user_id
    add_index :purchases, :year_id
  end
end
