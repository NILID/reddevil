class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :total, default: 0
      t.references :user
      t.references :round

      t.timestamps
    end
    add_index :results, :user_id
    add_index :results, :round_id
  end
end
