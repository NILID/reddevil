class AddPositionToRow < ActiveRecord::Migration[5.2]
  def change
    add_column :rows, :position, :integer
  end
end
