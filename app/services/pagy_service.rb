class PagyService
  def filter_by_category(category, filter)
    category.books.by_filter(filter)
  end

  def default_filter(filter)
    Book.by_filter(filter)
  end
end
