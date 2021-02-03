class RemoveMachineFromManufactures < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufactures, :machine, :string
  end
end
