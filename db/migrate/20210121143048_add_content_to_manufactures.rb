class AddContentToManufactures < ActiveRecord::Migration[5.2]
  def change
    add_column :manufactures, :content, :text
  end
end
