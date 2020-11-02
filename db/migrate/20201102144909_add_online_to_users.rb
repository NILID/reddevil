class AddOnlineToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :online_at, :datetime, null: false, default: DateTime.now
    User.all.each do |u|
      u.update_attribute(:online_at, u.updated_at)
    end
  end
end
