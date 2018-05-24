class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :title
      t.text :content
      t.integer :groups_mask
      t.references :user

      t.timestamps
    end
    add_index :materials, :user_id
  end
end
