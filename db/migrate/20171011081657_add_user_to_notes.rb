class AddUserToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :user_id, :integer, default: nil
    add_index :notes, :user_id
  end
end
