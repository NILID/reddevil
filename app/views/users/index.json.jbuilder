json.array!(@users) do |user|
  json.extract! user, :id
  json.title user.id
  json.start user.start_time
  json.end user.start_time
  json.url user_profile_url(user)
  json.allDay true
end