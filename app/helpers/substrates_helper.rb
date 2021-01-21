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
      content_tag(:span, text.html_safe, class: otk_status_style(status))
    else
      nil
    end
  end

  def otk_status_text(status, angle=true)
    unless status.empty?
      text = if angle
          fa_icon('angle-down', text: t("substrates.otk_statuses.#{status}"), right: true, class: 'ml-2')
        else
          t("substrates.otk_statuses.#{status}")
        end
      content_tag(:span, text.html_safe, class: status_style(status))
    else
      nil
    end
  end

  def otk_status_icon(status, size='fa-2x')
    unless status.empty?
      fa_icon(otk_icon(status), type: :far, class: "#{size} text-#{status_color(status)}")
    else
      nil
    end
  end

  def otk_icon(status)
    case status
    when 'empty'
      'calendar-minus'
    when 'failed'
      'calendar-times'
    when 'approval'
      'calendar'
    else
      'calendar-check'
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
         'false',
         'failed'   then 'danger'
    when 'finished',
         'passed',
         'true'     then 'success'
    when 'worked',
         'approval' then 'primary'
    when 'shipped'  then 'violet'
    else
      'secondary'
    end
  end

  def status_style(status, tag = :badge)
    color = status_color(status)
    tag == :badge ? "badge badge-#{color}" : "table-#{color}"
  end

  def otk_status_style(status, tag = :badge)
    color = status_color(status)
    tag == :badge ? "badge badge-#{color}" : "table-#{color}"
  end

  def priority_style(priority)
    color = case priority
    when 3 then 'bg-success text-white'
    when 2 then 'bg-warning text-white'
    when 1 then 'bg-danger text-white'
    end
    "badge rounded-circle shadow-lg substrate-priority px-2 #{color}"
  end

  def priority_color(priority)
    color = case priority
    when 3 then 'table-success'
    when 2 then 'table-warning'
    when 1 then 'table-danger'
    end
    color
  end

  def priority_select_tag(priority)
    content_tag(:span, class: 'select-priority') do
      content_tag(:span, priority, class: priority_style(priority))
    end
  end

  def priority_tag(priority)
    if priority
      content_tag(:span, priority, class: priority_style(priority))
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

  def otk_status_index(status)
    Substrate::OTK_STATUSES.index(status)
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
