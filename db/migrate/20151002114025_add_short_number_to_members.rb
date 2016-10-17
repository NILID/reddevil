class AddShortNumberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :short_number, :string, default: nil
  end
end
