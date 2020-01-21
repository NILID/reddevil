class CreatePurchases < ActiveRecord::Migration[4.2]
  def change
    create_table :purchases do |t|
      t.references :user
      t.references :table
      t.timestamps
    end
    add_index :purchases, :user_id
    add_index :purchases, :table_id
  end
end
