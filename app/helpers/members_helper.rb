module MembersHelper
  def show_birth(object)
    l object.birth, format: :short
  end

  def is_holiday(vacations, date, day, check_holiday)
    arr = []
    vacations.each do |v|
      if v.new_check_vac(date, day)
        if v.flag == 'rest'
          arr << 'bg-primary'
        elsif v.flag == 'trip'
          arr << 'bg-warning'
        elsif v.flag == 'remote'
          arr << 'bg-success'
        else
          arr << 'bg-danger'
        end
      end
    end
    return arr.empty? ? holiday_color(check_holiday) : arr
  end

  def holiday_color(boolean_flag)
    boolean_flag ? 'bg-red-10' : nil
  end

  def daynames_and_color(days_count, current_date)
    collection = []
    (1..days_count).each do |day|
      dayname = rus_dayname(current_date.change(day: day))
      collection << [day, (%w[Сб Вс].include? dayname), dayname]
    end
    return collection
  end

  def trip_period(startdate, enddate, viceuser)
    if startdate == enddate
      title = viceuser ? 'vacations.trip_in_viceuser' : 'vacations.trip_in'
      get_date = startdate
    else
      title = viceuser ? 'vacations.until_trip_viceuser' : 'vacations.until_trip'
      get_date = enddate
    end
    t(title, date: Russian.strftime(get_date, '%e %B'), vice: viceuser&.surname_name)
  end

  def remote_status(member)
    if member
      now = DateTime.now.beginning_of_day
      vacations = member.vacations.where('startdate <= ?', now)
                                  .where('enddate >= ?', now)
                                  .where(flag: 'remote')
      vacations.any? ? content_tag(:span, t('member.remote'), class: 'badge badge-secondary') : nil
    end
  end

  def position_link_text(position)
    position || t('shared.empty')
  end
end
