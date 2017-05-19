class AddEmptyMatchToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :empty_match, :boolean, default: false
  end
end
