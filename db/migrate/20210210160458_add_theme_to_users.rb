class AddThemeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :theme, :string, default: 'default'
  end
end
