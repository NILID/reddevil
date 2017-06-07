class CreateSubstrates < ActiveRecord::Migration
  def change
    create_table :substrates do |t|
      t.string :title
      t.string :drawing
      t.string :number
      t.string :state
      t.references :user
      t.text :desc

      t.timestamps
    end
    add_index :substrates, :user_id
  end
end
