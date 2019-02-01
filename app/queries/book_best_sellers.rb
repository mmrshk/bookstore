class BookBestSellers
  def initialize; end

  def call
    best_sellers
  end

  private

  def best_sellers
    Book.find(Order.payed.joins(:line_items).group(:book_id).order('sum("line_items"."quantity") DESC').count.keys)
  end
end
