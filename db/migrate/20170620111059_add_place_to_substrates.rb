class AddPlaceToSubstrates < ActiveRecord::Migration
  def change
    add_column :substrates, :place, :integer
  end
end
