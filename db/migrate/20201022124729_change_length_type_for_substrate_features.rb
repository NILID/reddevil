class ChangeLengthTypeForSubstrateFeatures < ActiveRecord::Migration[5.2]
  def up
    change_column :substrate_features, :length, :string
  end

  def down
    change_column :substrate_features, :length, :integer
  end
end
