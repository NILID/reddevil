class CreateManufactureOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :manufacture_operations do |t|
      t.bigint :manufacture_id, foreign_key: true, index: true
      t.bigint :operation_id, foreign_key: true, index: true
      t.integer :member_id, foreign_key: true, index: true
      t.date :started_at
      t.date :finished_at
    end
  end
end
