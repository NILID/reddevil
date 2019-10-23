class ChangeDefaultRolesToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :roles_mask, from: nil, to: 64
  end
end
