class AddPropotionsToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :propotions, :string
  end
end
