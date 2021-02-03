class CreateManufactures < ActiveRecord::Migration[5.2]
  def change
    create_table :manufactures do |t|
      t.string :title
      t.string :drawing
      t.string :material
      t.string :user
      t.string :machine
      t.string :priority

      t.timestamps
    end
  end
end
