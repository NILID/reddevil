class AddWinForecastsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :win_forecasts_count, :integer, default: 0
  end
end
