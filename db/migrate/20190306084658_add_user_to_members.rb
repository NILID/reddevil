class AddUserToMembers < ActiveRecord::Migration[5.0]
  def change
    add_reference :members, :user, foreign_key: true, index: true
  end
end
