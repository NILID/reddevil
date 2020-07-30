class AddLiteraToSubstrateFeatures < ActiveRecord::Migration[5.2]
  def change
    add_column :substrate_features, :litera, :string
  end
end
