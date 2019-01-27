# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

4.times do
  User.create!(email: FFaker::Internet.safe_email,
               password: "test#{rand(100...999)}XX")
end

# user = User.last
# users = User.all

['Mobile development', 'Photo', 'Web development', 'Web design'].each do |category|
  Category.create(title: category)
end

categories = Category.all

32.times do
  Author.create(firstname: FFaker::Name.first_name,
                lastname: FFaker::Name.last_name,
                biography: FFaker::Lorem.paragraph)
end

authors = Author.all

def book_authors(authors)
  selected_authors = []
  rand(1..3).times do
    author = authors.sample
    selected_authors << author unless selected_authors.include?(author)
  end
  selected_authors
end

used_book_titles = []

# 20.times do |index|
#   title = FFaker::Book.title
#   used_book_titles.include?(title) ? title << " #{index}" : used_book_titles << title
#
#   Book.create!(title: title,
#               price: rand(1..99),
#               description: FFaker::Lorem.paragraphs.join('. ') + FFaker::Lorem.paragraphs.join('. '),
#               quantity: rand(0...20),
#               dimension_h: rand(7.5...10.0).floor(2),
#               dimension_w: rand(4.5...5.5).floor(2),
#               dimension_d: rand(0.3...4.0).floor(2),
#               year: rand(2001..2019),
#               material: FFaker::Lorem.words.join(', '),
#               category_id: categories.sample.id,
#               image: "assets/images/test.png"
#               )
# end
#
# books = Book.all

# books.each do |book|
#   book_authors(authors).each do |author|
#     author_range_first = rand(1...32)
#     author_range_second = rand(1...32)
#     book.author_ids = [author_range_first, author_range_second] if author_range_first != author_range_second
#   end
#
#   rand(1..4).times do
#     Review.create!(name: FFaker::Lorem.words.join(', '),
#                   comment: FFaker::Lorem.sentences.join('. '),
#                   rating: rand(1..5),
#                   publish: true,
#                   book_id: book.id,
#                   user_id: users.sample.id)
#   end
# end

Delivery.create(name: 'Nova Poshta', time: '3', price:  30.00)
Delivery.create(name: 'Ukr Poshta', time: '5', price: 20.00)
