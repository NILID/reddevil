class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.boolean :hidden, default: false

      t.timestamps
    end
    add_index :categories, :ancestry
  end
end
