class CreateVacations < ActiveRecord::Migration[4.2]
  def change
    create_table :vacations do |t|
      t.datetime :startdate, null: false
      t.datetime :enddate, null: false
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
