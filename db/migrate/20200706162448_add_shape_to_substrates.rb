class AddShapeToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :shape, :string, default: nil
    add_column :substrates, :diameter, :float, default: nil
    add_column :substrates, :thickness, :float, default: nil
    add_column :substrates, :width, :float, default: nil
    add_column :substrates, :height, :float, default: nil
  end
end
