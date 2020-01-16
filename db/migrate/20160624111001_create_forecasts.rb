class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true
      t.integer :team1goal
      t.integer :team2goal
      t.integer :winner_id,  default: nil, index: true, foreign_key: true
      t.string  :ending,     default: 'basic'
      t.boolean :full_guess, default: false

      t.timestamps
    end
  end
end
