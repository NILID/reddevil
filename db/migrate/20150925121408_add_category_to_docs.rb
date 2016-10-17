class AddCategoryToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :category_id, :integer
  end
end
