class DestroyCategoryIdFromDocs < ActiveRecord::Migration
  def change
    remove_column :docs, :category_id
  end
end
