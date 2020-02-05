class PagyService
  def initialize(category, filter)
    @category = category
    @filter = filter
  end

  def call
    (@category ? filter_by_category : default_filter).includes(:authors)
  end

  private

  def filter_by_category
    @category.books.by_filter(@filter)
  end

  def default_filter
    Book.by_filter(@filter)
  end
end
