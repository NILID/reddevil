current_year = DateTime.now.year

json.array!(@members) do |member|
  birth_date = member.birth.change(year: current_year)
  json.title t('member.birthday_of', name: member.petrovich_fullname)
  json.tooltip t('member.birthday_of', name: member.petrovich_fullname)
  json.start birth_date
  json.end birth_date
  json.allDay true
  json.backgroundColor '#bd2e3d'
  json.borderColor '#681720'
end