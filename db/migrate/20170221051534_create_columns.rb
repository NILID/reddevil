class CreateColumns < ActiveRecord::Migration[4.2]
  def change
    create_table :columns do |t|
      t.string :name
      t.string :column_type
      t.references :table

      t.timestamps
    end
    add_index :columns, :table_id
  end
end
