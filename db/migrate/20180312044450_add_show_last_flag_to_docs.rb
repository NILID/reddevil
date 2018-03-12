class AddShowLastFlagToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :show_last_flag, :boolean, default: true
  end
end
