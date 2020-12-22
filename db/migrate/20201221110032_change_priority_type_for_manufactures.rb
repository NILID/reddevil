class ChangePriorityTypeForManufactures < ActiveRecord::Migration[5.2]
  def up
    remove_column :manufactures, :priority
    add_column :manufactures, :priority, :integer, default: 4, null: false
  end

  def down
    remove_column :manufactures, :priority
    add_column :manufactures, :priority, :string
  end

end
