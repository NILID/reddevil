class RemoveRemoteFlagFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :remote_flag
  end
end
