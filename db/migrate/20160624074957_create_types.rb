class CreateTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :types do |t|
      t.string :title

      t.timestamps
    end
  end
end
