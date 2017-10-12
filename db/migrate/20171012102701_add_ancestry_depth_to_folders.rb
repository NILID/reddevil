class AddAncestryDepthToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :ancestry_depth, :integer, default: 0
    Folder.rebuild_depth_cache!
  end
end
