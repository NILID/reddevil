class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :position
      t.bigint :department_id, foreign_key: true, index: true
      t.integer :member_id, foreign_key: true, index: true
      t.date :moved_at

      t.timestamps
    end
  end
end
