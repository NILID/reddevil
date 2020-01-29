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

  def select_text(status)
    color = case status
    when 'false' then 'danger'
    when 'true'  then 'success'
    else
      'secondary'
    end

    text = t("columns.booleans.#{status}")
    fa_icon('circle', text: text, class: "text-#{color}")
  end

  def status_style(status, tag = :badge)
    color = case status
    when 'opened'   then 'danger'
    when 'false'    then 'danger'
    when 'finished' then 'success'
    when 'true'     then 'success'
    when 'worked'   then 'primary'
    when 'shipped'  then 'violet'
    else
      'secondary'
    end
    tag == :badge ? "badge badge-#{color}" : "table-#{color}"
  end

  # remove
  def priority_style(priority)
    color = case priority
    when 'normal' then 'bg-success'
    when 'high'   then 'bg-danger'
    end
    "status-label rounded-circle #{color}"
  end

  def new_priority_style(priority)
    color = case priority
    when 4 then 'bg-success text-white'
    when 3 then 'bg-yellow'
    when 2 then 'bg-warning'
    when 1 then 'bg-danger text-white'
    end
    "badge rounded-circle shadow-lg substrate-priority px-2 #{color}"
  end


  # remove
  def priority_select_tag(priority)
    content_tag(:span, class: 'select-priority') do
      content_tag(:span, '', class: priority_style(priority)) +
      content_tag(:span, t("substrates.priorities.#{priority}"), class: 'option-text align-top ml-2')
    end
  end

  def new_priority_select_tag(priority)
    content_tag(:span, class: 'select-priority') do
      content_tag(:span, priority, class: new_priority_style(priority))
    end
  end

  # remove
  def priority_tag(priority)
    unless priority.empty?
      title_text = 'Приоритет: ' + t("substrates.priorities.#{priority}")
      content_tag(:span, '', class: priority_style(priority), title: title_text , data: { toggle: 'tooltip' })
    end
  end

  def new_priority_tag(priority)
    if priority
      content_tag(:span, priority, class: new_priority_style(priority))
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
      razd = short ? '<hr class="my-1"/>' : ' | '
      result.join(razd)
    end
  end
end
