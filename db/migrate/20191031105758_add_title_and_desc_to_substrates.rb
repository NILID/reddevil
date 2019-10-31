class AddTitleAndDescToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :title, :string
    add_column :substrates, :desc, :text
  end
end
