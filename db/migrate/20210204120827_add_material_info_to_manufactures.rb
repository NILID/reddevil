class AddMaterialInfoToManufactures < ActiveRecord::Migration[5.2]
  def change
    add_column :manufactures, :material_info, :string, default: ''
  end
end
