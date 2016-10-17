class AddWinnerToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner_id, :integer, default: nil
    add_index :matches, :winner_id
  end
end
