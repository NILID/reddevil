module MembersHelper
  def show_birth(object)
    l object.birth, format: :short
  end

  def is_holiday(vacations, date, day)
    vacations.each do |v|
      return (v.flag == 'rest' ? 'bg-primary' : 'bg-danger') if v.new_check_vac(date, day)
    end
    nil
  end
end
