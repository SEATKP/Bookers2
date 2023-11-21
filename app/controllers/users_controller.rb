class UsersController < ApplicationController

  before_action :ensure_current_user,{only:[:edit,:update]}

  def ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
    flash[:success]="You have created book successfully."
  end

  def index
    @users = User.all

    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])

    @books = @user.books

    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(@user.id)
        flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  def book_params
    params.require(:book).permit(:title,:body)
  end
end