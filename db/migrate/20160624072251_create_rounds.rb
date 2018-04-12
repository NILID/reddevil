class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :title
      t.string :content
      t.boolean :close, default: false
      t.datetime :deadline
      t.integer :type_id
      t.boolean :empty_match, default: false

      t.timestamps
    end
  end
end
