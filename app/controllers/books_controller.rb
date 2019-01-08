class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    @latest_books = Book.latest_books
  end

  def new
    @book = Book.new
    @author = Author.all.map { |author| [author.firstname + " " + author.lastname, author.id]}
    @categories = Category.all.map { |category| [category.title, category.id]}
  end

  def create
    @book = Book.new(book_params)
    @book.category_id = params[:category_id ]
    @book.author_ids = params[:author_ids]

    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find_by(title: @book.category)
  end

  def edit
    @authors = Author.all.map { |author| [author.firstname + " " + author.lastname, author.id]}
    @categories = Category.all.map { |category| [category.title, category.id]}
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  def update
    @book.category_id = params[:category_id]
    @book.author_ids = params[:author_ids]

    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,
                                 :description,
                                 :author,
                                 :price,
                                 :quantity,
                                 :material,
                                 :category_id,
                                 :author_ids,
                                 :year,
                                 :dimension_h,
                                 :dimension_w,
                                 :dimension_d)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
