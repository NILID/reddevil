class RemoveFileFromDoc < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :docs, :file
  end
end
