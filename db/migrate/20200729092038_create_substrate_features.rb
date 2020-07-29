class CreateSubstrateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :substrate_features do |t|
      t.integer :length
      t.string :sign
      t.string :wave
      t.float :feature
      t.references :substrate

      t.timestamps
    end
  end
end
