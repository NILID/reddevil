class AddSidesToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :sides, :string
  end
end
