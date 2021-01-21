class AddManufactureGroupToManufacture < ActiveRecord::Migration[5.2]
  def change
    add_reference :manufactures, :manufacture_group, foreign_key: true
  end
end
