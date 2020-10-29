module MembersHelper
  def show_birth(object)
    l object.birth, format: :short
  end

  def is_holiday(vacations, date, day)
    vacations.each do |v|
      if v.new_check_vac(date, day)
        if v.flag == 'rest'
          return 'bg-primary'
        elsif v.flag == 'trip'
          return 'bg-warning'
        else
          return 'bg-danger'
        end
      end
    end
    nil
  end

  def trip_period(startdate, enddate)
    if startdate == enddate
      t('vacations.trip_in', date: Russian.strftime(startdate, '%e %B'))
    else
      t('vacations.until_trip', date: Russian.strftime(enddate, '%e %B'))
    end
  end

  def member_remote_link(member)
    member.remote_flag ? I18n.t('member.del_remote') : I18n.t('member.add_remote')
  end

  def remote_status(member)
    if member&:remote_flag?
      content_tag(:span, t('member.remote'), class: 'badge badge-secondary')
    end
  end
end
