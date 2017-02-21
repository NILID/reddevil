class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string :name
      t.string :type
      t.references :year

      t.timestamps
    end
    add_index :columns, :year_id
  end
end
