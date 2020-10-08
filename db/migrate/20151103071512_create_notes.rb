class CreateNotes < ActiveRecord::Migration[4.2]
  def change
    create_table :notes do |t|
      t.text :content
      t.string :status, default: 'new'
      t.text :review
      t.integer :user_id, default: nil

      t.timestamps
    end
    add_index :notes, :user_id
  end
end
