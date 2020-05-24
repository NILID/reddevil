class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.boolean :close, default: false

      t.timestamps
    end
  end
end
