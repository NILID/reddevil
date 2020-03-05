class CreateTables < ActiveRecord::Migration[4.2]
  def change
    create_table :tables do |t|
      t.string :title
      t.integer :tableable_id
      t.string  :tableable_type
      t.timestamps
    end
    add_index :tables, [:tableable_id, :tableable_type]
  end
end
