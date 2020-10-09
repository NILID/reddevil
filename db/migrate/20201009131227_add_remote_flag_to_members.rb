class AddRemoteFlagToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :remote_flag, :boolean, default: false
  end
end
