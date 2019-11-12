class ChangesStatusToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :statuses_mask, :integer, default: 1
  end
end
