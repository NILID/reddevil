class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.text :desc
      t.attachment :file

      t.timestamps
    end
  end
end
