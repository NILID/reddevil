class AddColorToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :color, :string, default: '#ccc'
  end
end
