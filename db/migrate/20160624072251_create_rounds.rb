class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :title
      t.string :content
      t.boolean :close, default: false

      t.timestamps
    end
  end
end
