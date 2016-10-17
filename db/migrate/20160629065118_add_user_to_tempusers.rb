class AddUserToTempusers < ActiveRecord::Migration
  def change
    add_column :tempusers, :user_id, :integer, default: nil
    add_index :tempusers, :user_id
  end
end
