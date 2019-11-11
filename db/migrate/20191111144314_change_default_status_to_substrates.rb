class ChangeDefaultStatusToSubstrates < ActiveRecord::Migration[5.2]
  def change
    change_column_default :substrates, :status, from: nil, to: 'opened'
  end
end
