class RemovePropotionsInSubstrate < ActiveRecord::Migration[5.2]
  def change
     remove_column :substrates, :propotions
  end
end
