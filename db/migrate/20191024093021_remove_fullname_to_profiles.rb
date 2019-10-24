class RemoveFullnameToProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :name
    remove_column :profiles, :surname
    remove_column :profiles, :patronymic
  end
end
