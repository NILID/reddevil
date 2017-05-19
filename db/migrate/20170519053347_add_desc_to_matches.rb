class AddDescToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :desc, :string
  end
end
