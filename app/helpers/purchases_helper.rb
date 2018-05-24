module PurchasesHelper
  def short_date(item)
    if item
      item = item.to_date
      if DateTime.now.year == item.year
        Russian.strftime(item, '%d %b')
      else
        short_date_year(item)
      end
    end
  end

  def short_date_year(item)
    Russian.strftime(item, '%d %b %Y') if item
  end
end
