class ChangePhoneInMembers < ActiveRecord::Migration
  def up
    change_column :members, :phone, :integer, limit: 8
  end

  def down
    change_column :profiles, :phone, :integer
  end
end
