class RemoveGroupFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :group
  end
end
