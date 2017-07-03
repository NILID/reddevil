class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :user
      t.references :machine
      t.datetime :start_time
      t.datetime :end_time
      t.integer :complete, default: 0, null: false

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :machine_id
  end
end
