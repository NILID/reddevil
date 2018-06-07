current_year = DateTime.now.year

json.array!(Vacation.all) do |holiday|
  json.title t('member.in_holiday', member: holiday.member.full_name)
  json.tooltip t('member.in_holiday', member: holiday.member.full_name)
  json.start holiday.startdate
  json.end holiday.enddate
  json.allDay true
  json.backgroundColor '#056fb9'
end