class AddDataToPositions < ActiveRecord::Migration[5.2]
  def change
    Member.all.each do |member|
      Position.create! member: member, department: member.department, position: member.position, moved_at: DateTime.now
    end
  end
end
