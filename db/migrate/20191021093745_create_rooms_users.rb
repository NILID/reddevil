class CreateRoomsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms_users, id: false do |t|
      t.belongs_to :room, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
