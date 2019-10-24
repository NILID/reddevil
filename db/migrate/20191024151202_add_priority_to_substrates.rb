class AddPriorityToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :priority, :string, default: 'normal'
  end
end
