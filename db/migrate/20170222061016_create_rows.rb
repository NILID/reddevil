class CreateRows < ActiveRecord::Migration[4.2]
  def change
    create_table :rows do |t|
      t.references :user
      t.references :table
      t.timestamps
    end
    add_index :rows, :user_id
    add_index :rows, :table_id
  end
end
