class MoveTempuserToProfile < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.profile.update_attribute(:total_result, u.tempuser.total_result) if u.tempuser
    end
  end
end
