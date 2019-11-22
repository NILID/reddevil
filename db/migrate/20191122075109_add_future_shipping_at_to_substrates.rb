class AddFutureShippingAtToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :future_shipping_at, :datetime
  end
end
