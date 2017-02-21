class AddBackgroundColorToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :background_color, :string, default: '#dbf1gc'
  end
end
