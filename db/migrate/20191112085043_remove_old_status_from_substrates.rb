class RemoveOldStatusFromSubstrates < ActiveRecord::Migration[5.2]
  def up
    remove_column :substrates, :status
  end

  def down
    add_column :substrates, :status, default: 'opened'
  end
end
