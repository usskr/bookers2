class BooksController < ApplicationController
  before_action :authenticate_user!
  
  impressionist :actions=> [:show]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @user = current_user
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| b.favorites.where(created_at: from...to).size <=> a.favorites.where(created_at: from...to).size}
  end

  def show
    @book = Book.find(params[:id])
    impressionist(@book, nil, unique: [:ip_address])
    @user = @book.user
    @books = Book.all
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
    
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
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
