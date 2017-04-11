module PurchasesHelper

  def short_date(item)
    Russian.strftime(item, '%d %b') if item
  end

  def short_date_year(item)
    Russian.strftime(item, '%d %b %Y') if item
  end


end
