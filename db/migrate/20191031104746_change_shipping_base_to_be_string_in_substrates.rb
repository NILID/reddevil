class ChangeShippingBaseToBeStringInSubstrates < ActiveRecord::Migration[5.2]
  def up
    change_column :substrates, :shipping_base, :string
  end

  def down
    change_column :substrates, :shipping_base, :text
  end
end
