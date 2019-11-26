module SubstratesHelper
  def status_text(status, editable=false)
    unless status.empty?
      if editable
        text = fa_icon('angle-down', text: t("substrates.statuses.#{status}"), right: true, class: 'ml-2')
      else
        text = t("substrates.statuses.#{status}")
      end
      content_tag(:span, text.html_safe, class: status_style(status))
    else
      nil
    end
  end

  def status_style(status, tag = :badge)
    color = case status
    when 'opened' then 'danger'
    when 'finished' then 'success'
    when 'worked' then 'primary'
    else
      'secondary'
    end
    tag == :badge ? "badge badge-#{color}" : "table-#{color}"
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

  def substrate_sides(substrate, short=false)
    sides = substrate.sides
    if sides
      result = []
      result << "A (#{substrate.coating_type})"   if ['a', 'ab'].include? substrate.sides
      result << "Б (#{substrate.coating_type_b})" if ['b', 'ab'].include? substrate.sides
      razd = short ? '<br/>' : ' | '
      result.join(razd)
    end
  end
end
