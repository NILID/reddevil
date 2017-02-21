module PurchasesHelper

  def short_date(item)
    Russian.strftime(item, '%d %b') if item
  end
end
