class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.datetime :doc
      t.datetime :delivery
      t.references :purchase

      t.timestamps
    end
    add_index :deliveries, :purchase_id
  end
end
