class AddWithoutContractToManufactureGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :manufacture_groups, :without_contract, :boolean, default: false
  end
end
