class AddPhoneToMembers < ActiveRecord::Migration
  def change
    add_column :members, :phone, :integer
  end
end
