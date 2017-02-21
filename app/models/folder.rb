class Folder < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :parent_id
  has_many :datasets, dependent: :destroy

  has_ancestry cache_depth: true

  validates :title, presence: true

  validate :check_uniq_title, :on => :create

  private

  def check_uniq_title
    if self.root?
      user = User.find(self.user_id)
      errors.add(:title, I18n.t('folder.already_exist_in_folder')) if user.folders.roots.pluck(:title).include? self.title
    else
      errors.add(:title, I18n.t('folder.already_exist_in_folder')) if self.siblings.pluck(:title).include? self.title
    end
  end

end