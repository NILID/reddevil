class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :team1
      t.references :team2
      t.integer :team1goal, default: nil
      t.integer :team2goal, default: nil
      t.integer :winner_id, default: nil
      t.string  :ending, default: 'basic'
      t.string  :desc
      t.references :round

      t.timestamps
    end
    add_index :matches, :team1_id
    add_index :matches, :team2_id
    add_index :matches, :round_id
    add_index :matches, :winner_id
  end
end
