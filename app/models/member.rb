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

end
