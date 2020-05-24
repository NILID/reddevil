class CreateDatasets < ActiveRecord::Migration[4.2]
  def change
    create_table :datasets do |t|
      t.string :title
      t.attachment :src
      t.references :user
      t.references :folder

      t.timestamps
    end
    add_index :datasets, :user_id
    add_index :datasets, :folder_id
  end
end
