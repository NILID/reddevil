class AddRadStrengthToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :rad_strength, :string, default: 'нет'
  end
end
