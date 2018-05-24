class CreateSubstrates < ActiveRecord::Migration
  def change
    create_table :substrates do |t|
      t.string :title
      t.string :drawing
      t.string :number
      t.string :state
      t.references :user
      t.text :desc
      t.string :theme
      t.integer :place
      t.string :category, null: false
      t.integer :substrate_id, default: nil

      t.timestamps
    end
    add_index :substrates, :substrate_id
    add_index :substrates, :user_id
  end
end
