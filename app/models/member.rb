class Member < ApplicationRecord
  has_many :vacations, inverse_of: :member
  has_many :positions, inverse_of: :member
  belongs_to :department, optional: true
  belongs_to :user,       optional: true

  GROUPS = %w[lab107 lab180 lab181 lab182 lab190 lab193 lab252 lab524 cleaning]

  validates :surname, :name, :patronymic, presence: true
  validate :check_birth
  validates :number,
    numericality: { greater_than_or_equal_to: 0 },
    allow_blank: true

  accepts_nested_attributes_for :vacations, reject_if: :all_blank, allow_destroy: true

  acts_as_birthday :birth

  scope :shown,      -> { where(archive_flag: false) }
  scope :archive,    -> { where(archive_flag: true) }
  scope :with_birth, -> { where(hide_year: false).where.not(birth: nil) }

  # validate birth

  def fullname
    "#{surname} #{name} #{patronymic}"
  end

  def surname_init
    "#{surname} #{name[0]}. #{patronymic[0]}."
  end

  def surname_name
    "#{surname} #{name}"
  end

  def petrovich_fullname
    Petrovich(lastname: surname, firstname: name,  middlename: patronymic).to(:genitive).to_s
  end

  def petrovich_surname_name
    Petrovich(lastname: surname, firstname: name).to(:genitive).to_s
  end


  def mday
    self.birth.strftime('%d')
  end

  def mmonth
    self.birth.strftime('%m')
  end

  def start_time
    self.birth.change(year: DateTime.now.year)
  end

  def age
    if self.birth
      current_month = DateTime.now.month
      current_year  = DateTime.now.year
      age = current_year - self.birth.year
      age -= 1 if (current_month < self.birth.month) || ((current_month == self.birth.month) && (DateTime.now.day < self.birth.day))
      age
    else
      nil
    end
  end

  def last_position
    self.positions.order(moved_at: :desc).first
  end

  def update_position(position=nil, department=nil)
    self.update_attributes( position: position, department_id: department )
  end

  private

  def check_birth
    errors.add(:birth, I18n.t('member.validates.failed_birth'))  if birth && !hide_year && (Date.today.year - birth.year) < 16
  end
end
