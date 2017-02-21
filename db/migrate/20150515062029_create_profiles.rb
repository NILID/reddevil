class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :login
      t.attachment :avatar

      t.timestamps
    end
  end
end
