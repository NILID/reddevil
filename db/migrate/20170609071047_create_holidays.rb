class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.references :member
      t.date :start
      t.date :end

      t.timestamps
    end
    add_index :holidays, :member_id
  end
end
