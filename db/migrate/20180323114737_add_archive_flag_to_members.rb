class AddArchiveFlagToMembers < ActiveRecord::Migration
  def change
    add_column :members, :archive_flag, :boolean, default: false, null: false
  end
end
