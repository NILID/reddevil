class RemoveOperationFromManufactures < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufactures, :operation
  end
end
