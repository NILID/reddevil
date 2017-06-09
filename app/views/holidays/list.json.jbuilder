json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :start, :end
  json.title 'Holidays' + holiday.member.full_name
  json.start holiday.start
  json.end (holiday.end + 1.day) # fuck.. why I must + one day?
  json.color '#FF8C00'
  json.allDay true
end