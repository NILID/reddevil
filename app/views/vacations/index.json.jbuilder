current_year = DateTime.now.year

json.array!(@vacations) do |holiday|
  json.title t('member.in_holiday', member: holiday.member.fullname)
  json.tooltip t('member.in_holiday', member: holiday.member.fullname)
  json.start holiday.startdate
  json.end holiday.enddate
  json.allDay true
  json.backgroundColor '#056fb9'
end