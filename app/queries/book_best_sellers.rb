class BookBestSellers
  COUNT_BOOK_BEST_SELLERS = 4

  def call
    Book.where(id: Order.payed.joins(:line_items)
        .group(:book_id).order('sum("line_items"."quantity") DESC').count.keys).first(COUNT_BOOK_BEST_SELLERS)
  end
end
