class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.text :desc
      t.references :art
      t.references :user

      t.timestamps
    end
    add_index :works, :art_id
    add_index :works, :user_id
  end
end
