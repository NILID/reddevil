class AddViceuserToVacations < ActiveRecord::Migration[5.2]
  def change
    add_column :vacations, :viceuser_id, :integer, foreign_key: true
  end
end
