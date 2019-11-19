class AddFinishedAtToSubstrates < ActiveRecord::Migration[5.2]
  def up
    add_column :substrates, :finished_at, :date

    Substrate.all.each do |s|
      if s.status == 'finished'
        s.finished_at = s.updated_at
        s.save!
      end
    end
  end

  def down
    remove_column :substrates, :finished_at
  end
end
