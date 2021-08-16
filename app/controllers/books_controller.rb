class BooksController < ApplicationController

  def index
    @user = current_user
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to '/'
  end

  def show
  end

end

private

def book_params
  params.require(:book).permit(:title, :body)
end