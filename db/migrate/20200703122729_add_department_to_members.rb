class AddDepartmentToMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :members, :department, foreign_key: true
  end
end
