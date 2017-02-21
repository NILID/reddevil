class ChangeDefaultBackgroundForProfile < ActiveRecord::Migration
  def up
    change_column :profiles, :background_color, :string, default: '#aecdf2'
  end

  def down
   cnange_column :profiles, :background_color, :string, default: '#dbf1gc'
  end
end
