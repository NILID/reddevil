class Vacation < ActiveRecord::Base
  belongs_to :member

  validates :startdate,
            :enddate,
            presence: true

  validate :check_dates

  scope :old,     lambda { where('enddate < ?',    DateTime.now) }
  scope :future,  lambda { where('startdate >= ?', DateTime.now) }
  scope :present, lambda { where('startdate <= ?', DateTime.now)
                          .where('enddate >= ?',   DateTime.now) }


  # Добавить проверку что отпуск не назначается на уже занятые даты
  private

    def check_dates
      errors.add(:startdate, I18n.t('art.already_exist')) if startdate && enddate && startdate > enddate
    end
end
