class Art < ActiveRecord::Base
  attr_accessible :deadline
  has_many :works, dependent: :destroy

  validates :deadline, presence: true

  validate :check_uniq_deadline, on: :create

  def closed?
    (Time.now.to_date - self.deadline.to_date).days > 0
  end

  private

  def check_uniq_deadline
    errors.add(:deadline, I18n.t('art.already_exist')) if Art.where('deadline BETWEEN ? AND ?', deadline.beginning_of_day, deadline.end_of_day).count > 0
  end
end
