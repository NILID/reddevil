current_year = DateTime.now.year

json.array!(Holidays.between(Date.civil(current_year, 1, 1), Date.civil(current_year, 12, 31), :full_ru, :reddevil_ru)) do |holiday|
  holiday_date = holiday[:date]
  holiday_name = holiday[:name]
  json.title holiday_name
  json.tooltip holiday_name
  json.start holiday_date
  json.end holiday_date
  json.allDay true
  json.backgroundColor '#51a351'
end