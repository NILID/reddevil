class ChangeDefaultAmountToSubstrates < ActiveRecord::Migration[5.2]
  def change
    change_column_default :substrates, :amount, from: nil, to: 1
  end
end
