json.array!(@members) do |member|
  json.extract! member, :id, :full_name
  json.title member.full_name
  json.tooltip t('member.birthday_of', name: member.petrovich_fullname)
  json.start member.start_time
  json.end member.start_time
  json.allDay true
end