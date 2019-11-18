class ChangeDefaultCoatingToSubstrates < ActiveRecord::Migration[5.2]
  def change
    change_column_default :substrates, :coating_type, from: nil, to: 'нет'
  end
end
