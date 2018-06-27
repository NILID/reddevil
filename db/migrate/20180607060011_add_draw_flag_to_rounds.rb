class AddDrawFlagToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :draw, :boolean, default: false
  end
end
