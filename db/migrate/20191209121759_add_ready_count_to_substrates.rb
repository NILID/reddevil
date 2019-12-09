class AddReadyCountToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :ready_count, :integer, default: 0
  end
end
