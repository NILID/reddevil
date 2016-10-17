class AddGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :groups_mask, :integer, :default => "1"
  end
end
