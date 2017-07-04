class AddSubstrateToSubstrates < ActiveRecord::Migration
  def change
    add_column :substrates, :substrate_id, :integer, default: nil
    add_index :substrates, :substrate_id
  end
end
