class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.string :status, default: 'new'

      t.timestamps
    end
  end
end
