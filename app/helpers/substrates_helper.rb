module SubstratesHelper
  def status_text(status)
    unless status.empty?
      text = t("substrates.statuses.#{status}")
      content_tag(:span, text, class: status_style(status))
    else
      nil
    end
  end

  def status_style(status)
    color = case status
    when 'opened' then 'danger'
    when 'finished' then 'success'
    when 'worked' then 'primary'
    else
      'secondary'
    end
    "badge badge-#{color}"
  end

  def priority_style(priority)
    color = case priority
    when 'normal' then 'bg-success'
    when 'high'   then 'bg-danger'
    end
    "status-label rounded-circle #{color}"
  end

  def priority_select_tag(priority)
    content_tag(:span, class: 'select-priority') do
      content_tag(:span, '', class: priority_style(priority)) +
      content_tag(:span, t("substrates.priorities.#{priority}"), class: 'option-text align-top ml-2')
    end
  end

  def priority_tag(priority)
    unless priority.empty?
      title_text = 'Приоритет: ' + t("substrates.priorities.#{priority}")
      content_tag(:span, '', class: priority_style(priority), title: title_text , data: { toggle: 'tooltip' })
    end
  end

  def status_index(status)
    Substrate::STATUSES.index(status)
  end

end
