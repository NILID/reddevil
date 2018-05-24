class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :login
      t.attachment :avatar
      t.string :background_color, default: '#aecdf2'
      t.string :name
      t.string :surname
      t.string :patronymic
      t.integer :total_result, default: 0

      t.timestamps
    end
  end
end
