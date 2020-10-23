class AddFavoritesDocsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorites_docs_count, :integer, default: 0
  end
end
