class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.references :user
      t.references :match
      t.integer :team1goal
      t.integer :team2goal
      t.integer :winner_id, default: nil
      t.string  :ending,    default: 'basic'

      t.timestamps
    end
    add_index :forecasts, :user_id
    add_index :forecasts, :match_id
    add_index :forecasts, :winner_id
  end
end
