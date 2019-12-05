class AddInstockToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :instock, :integer, default: 0
  end
end
