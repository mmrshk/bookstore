module BookHelper
  def book_authors(book)
    book.authors.map { |author| "#{author.firstname} #{author.lastname}" }.join(', ')
  end

  # remove to presenter
  def book_dimensions(book)
    "H: #{book.dimension_h} x W: #{book.dimension_w} x D: #{book.dimension_d}"
  end
end
