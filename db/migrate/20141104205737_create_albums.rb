class CreateAlbums < ActiveRecord::Migration[4.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :ancestry
      t.string :slug

      t.timestamps
    end
    add_index :albums, :ancestry
    add_index :albums, :slug, unique: true
  end
end
