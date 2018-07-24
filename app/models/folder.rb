class Folder < ActiveRecord::Base
  has_ancestry cache_depth: true

  belongs_to :user
  attr_accessible :title, :parent_id, :ancestry
  has_many :datasets, dependent: :destroy

  validates :title, presence: true

  validate :check_uniq_title, on: :create

  private

  def check_uniq_title
    folders = self.root? ? User.where(id: self.user_id).first.folders.roots : self.siblings
    errors.add(:title, I18n.t('folder.already_exist_in_folder')) if folders.pluck(:title).include? self.title
  end
end