class CreateProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.attachment :avatar
      t.string :background_color, default: '#aecdf2'
      t.integer :total_result, default: 0

      t.timestamps
    end
  end
end
