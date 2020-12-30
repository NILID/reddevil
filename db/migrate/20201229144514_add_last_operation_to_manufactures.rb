class AddLastOperationToManufactures < ActiveRecord::Migration[5.2]
  def change
    add_column :manufactures, :last_operation_id, :integer, foreign_key: true, index: true
  end
end
