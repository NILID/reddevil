class AddArchiveToDocs < ActiveRecord::Migration[5.2]
  def change
    add_column :docs, :archive, :boolean, default: false
  end
end
