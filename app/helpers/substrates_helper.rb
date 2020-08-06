module SubstratesHelper
  def rad_icon(rad, styles = nil, full = false)
    case rad
    when 'нет'
      full ? rad : nil
    else
      full ? (fa_icon rad_icon_name(rad), text: rad) : "fa fa-#{rad_icon_name(rad)} #{styles}"
    end
  end

  def rad_icon_name(name)
    case name
    when 'непрерывная'
      'slash'
    when 'импульсная'
      'wave-square'
    else
      return nil
    end
  end

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
    when 'false'   then 'danger'
    when 'true'    then 'success'
    when 'waiting' then 'primary'
    else
      'secondary'
    end

    text = t("columns.booleans.#{status}")
    content_tag(:span, text, class: "badge badge-#{color}")
  end

  def status_color(status)
    case status
    when 'opened',
         'false'    then 'danger'
    when 'finished',
         'true'     then 'success'
    when 'worked'   then 'primary'
    when 'shipped'  then 'violet'
    else
      'secondary'
    end
  end

  def status_style(status, tag = :badge)
    color = status_color(status)
    tag == :badge ? "badge badge-#{color}" : "table-#{color}"
  end

  def status_style_xls
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

  def substrate_feature(feature)
    length = feature.length? ? "#{feature.length} нм; " : ''
    litera = feature.litera? ? "<strong>#{feature.litera}</strong> " : ''
    [length, litera, fa_icon(feature.sign), ' ', feature.feature].join.html_safe
  end

  def status_index(status)
    Substrate::STATUSES.index(status)
  end

  def substrate_sides(substrate, side, short=false)
    sides = substrate.sides
    if side == :a
      literal = 'А'
      type = substrate.coating_type
    else
      literal = 'Б'
      type = substrate.coating_type_b
    end
    "#{literal} (#{type})"   if ['a', 'ab'].include? substrate.sides
  end
end
