class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.references :user
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :events, :user_id
  end
end
