class UsersController < ApplicationController

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def create
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

end
