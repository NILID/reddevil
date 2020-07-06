class OfficeNote < ApplicationRecord
  belongs_to :user

  has_many_attached :documents

  after_initialize :generate_data, on: [:create]

  validates :num, :whom, :title, presence: true
  validates :num, format: { with: /\A180\/05-[0-9]{2,}\z/ }
  validate :check_num

  # Получение выборки служебок за текущий год (по умолчанию)
  # либо за указанный год (например в валидации)
  scope :current_year_notes,
    -> (year = Date.today.year) { where('extract(year from created_at) = ?', year).order(num: :desc) }

  #
  # Функция для автоматического получения номера служебки,
  # генерируется последняя часть с минимум двумя знаками.
  # В начале года, если отсутствуют служебки за текущий год,
  # нумерация начинается заново с 01.
  # При создании новой служебки, нумерация идет следущей (+1)
  # от предыдущей служебки за текущий год.
  #

  def generate_data
    self.num ||= "180/05-%02d" % (OfficeNote.last_num + 1)
    self.created_at ||= Date.today
  end

  def self.last_num
    last_not = OfficeNote.current_year_notes.first
    last_not.nil? ? 0 : last_not.num.match(/[0-9]+\z/).to_a.first.to_i
  end

  private

    def check_num
      year = created_at.year
      notes = OfficeNote.current_year_notes(year).where(num: num) - [self]
      errors.add(:num, "уже существует на #{year} год") if notes.any?
    end
end
