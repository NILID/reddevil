class CreateSubfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :subfiles do |t|
      t.attachment :src
      t.references :substrate, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
