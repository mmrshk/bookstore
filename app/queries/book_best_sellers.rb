class BookBestSellers
  def call
    Book.find(Order.payed.joins(:line_items).group(:book_id).order('sum("line_items"."quantity") DESC').count.keys)
  end
end
