class AddNewFieldsToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :coating_type, :string
    add_column :substrates, :wave, :string
    add_column :substrates, :corner, :string
    add_column :substrates, :frame, :boolean, default: false
  end
end
