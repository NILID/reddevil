class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.datetime :deadline

      t.timestamps
    end
  end
end
