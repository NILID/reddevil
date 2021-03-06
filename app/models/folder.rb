class Folder < ApplicationRecord
  has_ancestry cache_depth: true

  belongs_to :user
  has_many :datasets, dependent: :destroy

  validates :title, presence: true

  validate :check_uniq_title, on: :create

  private

  def check_uniq_title
    folders = self.root? ? User.where(id: self.user_id).first.folders.roots : self.siblings
    errors.add(:title, I18n.t('folder.already_exist_in_folder')) if folders.pluck(:title).include? self.title
  end
end