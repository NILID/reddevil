class ChangeTypesOfDatefieldsInSubstrates < ActiveRecord::Migration[5.2]

  def up
    change_column :substrates, :arrival_at, :date
    change_column :substrates, :shipping_at, :date
  end

  def down
    change_column :substrates, :arrival_at, :datetime
    change_column :substrates, :shipping_at, :datetime
  end
end
