class AddWorkPhoneToMembers < ActiveRecord::Migration
  def change
    add_column :members, :work_phone, :integer, limit: 8
  end
end
