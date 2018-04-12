class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.text :desc
      t.attachment :file
      t.boolean :show_last_flag, default: true

      t.timestamps
    end
  end
end
