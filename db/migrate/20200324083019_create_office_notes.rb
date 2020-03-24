class CreateOfficeNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :office_notes do |t|
      t.string :num,   null: false
      t.string :title, null: false
      t.string :whom,  null: false

      t.timestamps
    end
  end
end
