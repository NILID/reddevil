today = Date.today
prev_month = today.prev_month
next_month = today.next_month

json.array!(Holidays.between(Date.civil(prev_month.year, prev_month.month, 1), Date.civil(next_month.year, next_month.month, 31), :full_ru, :reddevil_ru)) do |holiday|
  holiday_date = holiday[:date]
  holiday_name = holiday[:name]
  json.title holiday_name
  json.tooltip holiday_name
  json.start holiday_date
  json.end holiday_date
  json.allDay true
  json.backgroundColor '#51a351'
end