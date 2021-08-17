class BooksController < ApplicationController

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      redirect_to book_path(book.id), notice: 'You have created book successfully.'
    else
      flash.now[:danger] = "create error"
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book_detail = Book.find(params[:id])
    @user = @book_detail.user
    @book = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      flash.now[:danger] = "update error"
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

end

private

def book_params
  params.require(:book).permit(:title, :body)
end
