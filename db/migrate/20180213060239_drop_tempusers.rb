class DropTempusers < ActiveRecord::Migration
  def change
    drop_table :tempusers
  end
end
