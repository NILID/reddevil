class CreateColumnships < ActiveRecord::Migration[4.2]
  def change
    create_table :columnships do |t|
      t.references :column
      t.references :purchase
      t.text :data
      t.text :desc
    end

    add_index :columnships, :column_id
    add_index :columnships, :purchase_id
  end
end
