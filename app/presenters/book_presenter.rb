class BookPresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
  end

  def book_authors
    authors.map { |author| "#{author.firstname} #{author.lastname}" }.join(', ')
  end

  def book_dimensions
    "H: #{dimension_h} x W: #{dimension_w} x D: #{dimension_d}"
  end

  def book_reviews
    @model.reviews.where(publish: true).count
  end

  private

  def method_missing(*args, &block)
    @model.public_send(*args, &block)
  end
end
