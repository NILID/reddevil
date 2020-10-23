class CreateSubstrates < ActiveRecord::Migration[4.2]
  def change
    create_table :substrates do |t|
      t.string :drawing
      t.string :detail
      t.integer :amount
      t.string :contract
      t.datetime :arrival_at
      t.string :arrival_from
      t.datetime :shipping_at
      t.string :shipping_to
      t.text :shipping_base
      t.integer :ready_count, default: 0
      t.integer :instock, default: 0
      t.string :wave_b
      t.string :corner_b

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
