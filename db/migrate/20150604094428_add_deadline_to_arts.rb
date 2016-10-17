class AddDeadlineToArts < ActiveRecord::Migration
  def change
    add_column :arts, :deadline, :datetime
  end
end
