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

  private

  def method_missing(*args, &block)
    @model.send(*args, &block)
  end
end
