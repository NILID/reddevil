class AddCoatingTypeBToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :coating_type_b, :string, default: 'нет'
  end
end
