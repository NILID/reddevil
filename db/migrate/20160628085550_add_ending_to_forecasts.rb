class AddEndingToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :ending, :string, default: 'basic'
  end
end
