class RemoveScreenshotFromNotes < ActiveRecord::Migration[5.2]
  def up
    remove_attachment :notes, :screenshot
  end

  def down
    add_attachment :notes, :screenshot
  end
end
