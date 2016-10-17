class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.references :tempuser
      t.references :match
      t.integer :team1goal
      t.integer :team2goal

      t.timestamps
    end
    add_index :forecasts, :tempuser_id
    add_index :forecasts, :match_id
  end
end
