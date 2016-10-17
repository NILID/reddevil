class AddHideToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :hide, :boolean, default: false
  end

  def self.down
    remove_column :sources, :hide
  end
end
