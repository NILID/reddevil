class AddPriorityxToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :priorityx, :integer, default: 4, null: false

    Substrate.all.each do |s|
      if s.priority == 'high'
        s.update_attribute(:priorityx, 1)
      elsif s.priority == 'normal'
        s.update_attribute(:priorityx, 4)
      end
    end
  end
end
