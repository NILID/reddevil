class Material < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :groups_mask, :title, :groups

  def groups=(groups)
    self.groups_mask = (groups & User::GROUPS).map { |p| 2**User::GROUPS.index(p) }.inject(0, :+)
  end

  def groups
    User::GROUPS.reject do |p|
       ((groups_mask.to_i || 0) & 2**User::GROUPS.index(p)).zero?
    end
  end

   def has_group?(group)
     groups.include?(group.to_s)
   end
end
