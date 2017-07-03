json.array!(@tasks) do |task|
  task_title = "#{task.title}. #{task.user.profile.surname}"
  json.title task_title
  json.tooltip task_title
  json.start task.start_time
  json.end task.end_time + 1.day
  json.allDay true
  json.backgroundColor '#51a351'
end
json.array!(@tasks) do |task|
  if task.next_task
    task_title = t('tasks.standstill')
    json.title task_title
    json.tooltip task_title
    json.start task.end_time + 1.day
    json.end task.next_task.start_time
    json.allDay true
    json.backgroundColor '#ccc'
  end
end