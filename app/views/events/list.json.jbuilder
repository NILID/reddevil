json.array!(@events) do |event|
  json.extract! event, :id, :title
  json.title event.title
  json.start event.start_date
  json.end event.end_date
  json.url user_event_url(event.user, event)
  json.color '#FF8C00'
  json.allDay true
end