class Member < ActiveRecord::Base
  has_many :vacations

  accepts_nested_attributes_for :vacations

  acts_as_birthday :birth

  scope :shown,      -> { where(archive_flag: false) }
  scope :archive,    -> { where(archive_flag: true) }
  scope :with_birth, -> { where.not(birth: nil) }

  def full_name
    "#{surname} #{name} #{patronymic}"
  end

  def petrovich_fullname
    Petrovich(lastname: surname, firstname: name,  middlename: patronymic).to(:genitive).to_s
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

  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << [I18n.t('symbols.number'), I18n.t('member.fullname')]
      all.each_with_index do |member, index|
        csv << [index+1, member.full_name]
      end
    end
  end
end
