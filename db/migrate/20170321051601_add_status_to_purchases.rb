class AddStatusToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :status, :string
    add_column :purchases, :status_color, :string
  end
end
