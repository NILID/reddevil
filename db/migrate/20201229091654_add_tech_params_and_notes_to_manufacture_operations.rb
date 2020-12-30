class AddTechParamsAndNotesToManufactureOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :manufacture_operations, :tech_params, :text
    add_column :manufacture_operations, :notes, :text
  end
end
