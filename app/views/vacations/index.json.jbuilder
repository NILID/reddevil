current_year = DateTime.now.year

json.array!(@vacations) do |vacation|
  flag = vacation.flag

  json.title t("member.in_#{flag}", member: vacation.member.fullname)
  json.tooltip t("member.in_#{flag}", member: vacation.member.fullname)
  json.start vacation.startdate
  json.end vacation.enddate + 1.day
  json.allDay true
  json.backgroundColor flag == 'sick' ? '#dc3545' : '#056fb9'
end