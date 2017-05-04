class AddTypeToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :type_id, :integer
  end
end
