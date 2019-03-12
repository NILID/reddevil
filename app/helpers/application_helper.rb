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

   def arttime(time)
     Russian.strftime(time, "%A %d.%m.%Y")
   end

   def deadline(time)
     Russian.strftime(time, "%d %B %Y %H:%M (%A)")
   end
end
