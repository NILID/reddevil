class AddSubstrateToSubstrates < ActiveRecord::Migration
  def change
    add_column :substrates, :substrate_id, :integer
    add_index :substrates, :substrate_id
  end
end
