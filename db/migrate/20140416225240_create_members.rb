class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.date :birth

      t.timestamps
    end
  end
end
