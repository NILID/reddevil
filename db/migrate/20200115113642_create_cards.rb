class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
