class Vacation < ActiveRecord::Base
  belongs_to :member

  FLAGS = %w[rest sick trip].freeze

  validates :startdate,
            :enddate,
            presence: true

#  validates :enddate,
#            presence: true,
#            if: -> { flag == 'rest' }

  validate :check_dates
  validates_inclusion_of :flag, in: FLAGS

  scope :old,     lambda { where('enddate < ?',    DateTime.now) }
  scope :future,  lambda { where('startdate >= ?', DateTime.now) }
  scope :present, lambda { where('startdate <= ?', DateTime.now)
                          .where('enddate >= ?',   DateTime.now) }

  def get_date
    enddate
  end

  def new_check_vac(date, day)
    (startdate..(enddate + 10.hour)).cover? DateTime.parse([date.year, date.month, day].join('-'))
  end

  # Добавить проверку что отпуск не назначается на уже занятые даты
  private

    def check_dates
      errors.add(:startdate, I18n.t('shared.already_exist')) if startdate && enddate && startdate > enddate
    end
end
