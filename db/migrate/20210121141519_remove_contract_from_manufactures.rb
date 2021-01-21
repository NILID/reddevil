class RemoveContractFromManufactures < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufactures, :contract
  end
end
