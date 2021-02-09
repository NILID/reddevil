class AddUpdatedUserToManufactures < ActiveRecord::Migration[5.2]
  def down
      add_column :manufactures, :updated_user_id, :integer, foreign_key: true
  end
end
