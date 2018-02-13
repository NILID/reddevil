class AddSportFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sport_flag, :boolean, default: true
  end
end
