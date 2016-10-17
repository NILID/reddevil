class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :title
      t.string :content
      t.references :type
      t.attachment :flag

      t.timestamps
    end
    add_index :teams, :type_id
  end
end
