class AddOtkToManufactures < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufactures, :otk
    add_column :manufactures, :otk_status, :string, default: 'empty'
    add_column :manufactures, :otk_desc, :text, default: nil
  end
end
