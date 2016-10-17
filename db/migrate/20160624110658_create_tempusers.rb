class CreateTempusers < ActiveRecord::Migration
  def change
    create_table :tempusers do |t|
      t.string :username

      t.timestamps
    end
  end
end
