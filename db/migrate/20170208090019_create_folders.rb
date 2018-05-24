class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.references :user
      t.string :ancestry
      t.integer :ancestry_depth, default: 0

      t.timestamps
    end
    add_index :folders, :ancestry
    add_index :folders, :user_id
    Folder.rebuild_depth_cache!
  end
end
