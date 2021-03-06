class CreateDocs < ActiveRecord::Migration[4.2]
  def change
    create_table :docs do |t|
      t.string :title
      t.text :desc
      t.boolean :show_last_flag, default: true

      t.timestamps
    end
  end
end
