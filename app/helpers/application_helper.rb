module ApplicationHelper

   def plural(count, value, with_count = true)
     val = "plural.#{value}"
     result = Russian::p(count, t("#{val}_1"), t("#{val}_2"), t("#{val}_10"))
     if with_count
       count.to_s + ' ' + result
     else
       result
     end
   end

   def short_date(time)
     Russian.strftime(time, '%d.%m.%Y')
   end

   def arttime(time)
     Russian.strftime(time, '%A, %d.%m.%Y')
   end

   def deadline(time)
     Russian.strftime(time, '%d %B %Y %H:%M (%A)')
   end

   def bootstrap_class_for flash_type
     { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
   end

   def flash_messages(opts = {})
     flash.each do |msg_type, message|
       concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
         concat content_tag(:button, fa_icon('close'), class: "close", data: { dismiss: 'alert' })
         concat message
       end)
     end
     nil
  end
end
