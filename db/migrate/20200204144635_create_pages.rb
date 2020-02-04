class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
