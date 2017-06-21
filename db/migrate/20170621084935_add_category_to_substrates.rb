class AddCategoryToSubstrates < ActiveRecord::Migration
  def change
    add_column :substrates, :category, :string, null: false
  end
end
