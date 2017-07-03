class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :title

      t.timestamps
    end
  end
end
