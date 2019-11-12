class ChangeDefaultStatusesMaskToSubstrates < ActiveRecord::Migration[5.2]
  def change
    change_column_default :substrates, :statuses_mask, from: 1, to: 0
  end
end
