class AddFinishedAtToSubstrates < ActiveRecord::Migration[5.2]
  def up
    add_column :substrates, :finished_at, :datetime
  end

  def down
    remove_column :substrates, :finished_at
  end
end
