module UsersHelper
  def last_seen(user)
    if user.online?
      content_tag(:span, t('users.online'), class: 'badge badge-success')
    else
      time_ago = distance_of_time_in_words(DateTime.now, user.online_at)
      time_ago_text = t('users.online_ago_html', time: time_ago)
      content_tag(:small, time_ago_text, class: 'text-muted' )
    end
  end
end
