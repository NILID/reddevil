class AddDeadlineToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :deadline, :datetime
  end
end
