class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.attachment :file
      t.references :work
      t.boolean :hide, default: false

      t.timestamps
    end
    add_index :sources, :work_id
  end
end
