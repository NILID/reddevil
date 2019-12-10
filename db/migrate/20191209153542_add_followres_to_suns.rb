class AddFollowresToSuns < ActiveRecord::Migration[5.2]
  def change
    Substrate.all.each do |s|
      s.users << s.followers(User)
    end
  end
end
