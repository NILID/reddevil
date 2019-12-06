class ChangeStatusToSubstrates < ActiveRecord::Migration[5.2]
  def change
    Substrate.all.each do |s|
      s.statuses_mask += 1
      s.save!
    end
  end
end
