class AddFullnameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :surname, :string
    add_column :profiles, :patronymic, :string
    add_column :profiles, :total_result, :integer, default: 0
  end
end
