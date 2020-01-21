class CreateTables < ActiveRecord::Migration[4.2]
  def change
    create_table :tables do |t|
      t.string :title
      t.string :category
      t.timestamps
    end
  end
end
