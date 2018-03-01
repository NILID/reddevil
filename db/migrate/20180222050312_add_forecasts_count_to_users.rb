class AddForecastsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forecasts_count, :integer
  end
end
