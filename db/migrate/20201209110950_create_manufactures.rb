class CreateManufactures < ActiveRecord::Migration[5.2]
  def change
    create_table :manufactures do |t|
      t.string :title
      t.string :drawing
      t.string :contract
      t.string :material
      t.string :user
      t.string :machine
      t.text :operation
      t.string :otk
      t.string :priority

      t.timestamps
    end
  end
end
