class ChangeDefaultSportFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :sport_flag, from: true, to: false
  end
end
