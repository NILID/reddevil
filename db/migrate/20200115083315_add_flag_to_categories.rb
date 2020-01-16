class AddFlagToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :flag, :string, default: nil
  end
end
