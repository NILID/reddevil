class AddMachineToManufactureOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :manufacture_operations, :machine, :string, default: ''
    ManufactureOperation.all.each do |mo|
      mo.update_attribute(machine: mo.manufacture.machine) if mo.manufacture && mo.manufacture.machine?
    end
  end
end
