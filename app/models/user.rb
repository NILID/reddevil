class User < ActiveRecord::Base
  acts_as_liker

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles
  # attr_accessible :title, :body
  after_create :set_role

  has_many :comments, dependent: :delete_all
  has_many :works
  has_one :profile, :dependent => :destroy
  has_one :tempuser
  ROLES = %w[admin user moderator editor test]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
     ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  GROUPS = %w[other lab193 test]

  def groups=(groups)
    self.groups_mask = (groups & GROUPS).map { |p| 2**GROUPS.index(p) }.inject(0, :+)
  end

  def groups
    GROUPS.reject do |p|
     ((groups_mask.to_i || 0) & 2**GROUPS.index(p)).zero?
    end
  end

  def has_group?(group)
    groups.include?(group.to_s)
  end

  private

  def set_role
    self.update_attribute(:roles_mask, 2)
    self.build_profile
  end

end
