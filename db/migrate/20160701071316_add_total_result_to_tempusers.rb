class AddTotalResultToTempusers < ActiveRecord::Migration
  def change
    add_column :tempusers, :total_result, :integer, default: 0
  end
end
