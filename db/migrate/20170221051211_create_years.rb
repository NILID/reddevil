class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.string :year
      t.string :slug, :unique => true, :null => false

      t.timestamps
    end
    add_index :years, :slug, unique: true
  end
end
