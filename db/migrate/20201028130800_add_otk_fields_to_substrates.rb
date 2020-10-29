class AddOtkFieldsToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :otk_status, :string, default: 'empty'
    add_column :substrates, :otk_desc, :text, default: nil
  end
end
