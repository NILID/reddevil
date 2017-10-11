class AddScreenshotToNotes < ActiveRecord::Migration
  def self.up
    add_attachment :notes, :screenshot
  end

  def self.down
    remove_attachment :notes, :screenshot
  end
end
