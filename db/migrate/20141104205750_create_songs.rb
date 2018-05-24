class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.references :album
      t.attachment :file

      t.timestamps
    end
    add_index :songs, :album_id
  end
end
