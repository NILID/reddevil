class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|

      t.timestamps
    end
  end
end
