class Member < ActiveRecord::Base
  attr_accessible :birth, :name, :patronymic, :surname, :email, :phone, :short_number

  acts_as_birthday :birth

  def full_name
    "#{surname} #{name} #{patronymic}"
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
    current_month = DateTime.now.month
    current_year = DateTime.now.year
    age = current_year - self.birth.year
    age -= 1 if (current_month < self.birth.month) || ((current_month == self.birth.month) && (DateTime.now.day < self.birth.day))
    return age
  end

end
