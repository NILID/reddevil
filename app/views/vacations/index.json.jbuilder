current_year = Date.today.year

json.array!(@vacations) do |vacation|
  flag = vacation.flag

  flag_color = if flag == 'sick'
    '#dc3545'
  elsif flag == 'trip'
    '#ffc107'
  else
    '#056fb9'
  end

  json.title t("member.in_#{flag}", member: vacation.member.fullname)
  json.tooltip t("member.in_#{flag}", member: vacation.member.fullname)
  json.start vacation.startdate
  json.end vacation.enddate + 1.day
  json.allDay true
  json.backgroundColor flag_color
end