class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.string :fullname
      t.string :departament
      t.text :position
      t.string :place
      t.string :phone_inter
      t.string :phone_city
      t.string :email

      t.timestamps
    end
  end
end
