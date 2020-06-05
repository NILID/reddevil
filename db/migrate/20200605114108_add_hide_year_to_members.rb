class AddHideYearToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_year, :boolean, default: false
  end
end
