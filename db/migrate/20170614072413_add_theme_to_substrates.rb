class AddThemeToSubstrates < ActiveRecord::Migration
  def change
    add_column :substrates, :theme, :string
  end
end
