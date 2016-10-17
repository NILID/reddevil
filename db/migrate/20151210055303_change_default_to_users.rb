class ChangeDefaultToUsers < ActiveRecord::Migration
  def up
    change_column :users, :roles_mask, :integer, default: nil
  end

  def down
    change_column :users, :roles_mask, :integer, default: 2
  end
end
