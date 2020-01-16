class AddShowTypeToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :show_type, :string
  end
end
