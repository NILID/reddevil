class CreateManufactureGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :manufacture_groups do |t|
      t.string :title, null: false, default: ''
      t.string :contract
      t.date :limit_at
      t.boolean :actual, null: false, default: false

      t.timestamps
    end
  end
end
