class AddFlagToVacations < ActiveRecord::Migration[5.2]
  def change
    add_column :vacations, :flag, :string, null: false
    Vacation.all.each { |v| v.update_attribute(:flag, 'rest') }
  end
end
