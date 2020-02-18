class AddPositionToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :position, :string
  end
end
