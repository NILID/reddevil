class AddFullGuessToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :full_guess, :boolean, default: false
  end
end
