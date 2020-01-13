class DropLoginInProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :login
  end
end
