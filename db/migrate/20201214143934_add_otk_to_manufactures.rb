class AddOtkToManufactures < ActiveRecord::Migration[5.2]
  def change
    add_column :manufactures, :otk_status, :string, default: 'empty'
    add_column :manufactures, :otk_desc, :text, default: nil
  end
end
