class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.date :birth
      t.string :email
      t.integer :phone, limit: 8
      t.string :short_number, default: nil
      t.integer :work_phone, limit: 8
      t.boolean :archive_flag, default: false, null: false

      t.timestamps
    end
  end
end
