class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name, index: true, unique: true
      t.references :user, index: true, foreign_key: true
      t.boolean :private, default: false, null: false

      t.timestamps
    end
  end
end
