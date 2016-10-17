class AddWinnerToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :winner_id, :integer, default: nil
    add_index :forecasts, :winner_id
  end
end
