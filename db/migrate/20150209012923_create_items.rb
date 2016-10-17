class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|

      t.attachment :file

      t.timestamps
    end
  end
end
