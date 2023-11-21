class UsersController < ApplicationController
  # コントローラの処理前に実行（editとupdateのみ）
  before_action :ensure_current_user,{only:[:edit,:update]}
  # bookのuser_idと、ログイン中のIDが異なる場合、book一覧にリダイレクトする
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
    # booksのuser_idカラムは現在ログイン中のIDで保存する
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
    flash[:success]="You have created book successfully."
  end

  def index
    @users = User.all
    # index内（ユーザー一覧）に投稿を置く場合、newが必要
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    # @userに紐付いたbooksのみを表示
    @books = @user.books
    # show内（ユーザ詳細）に投稿を置く場合、newが必要
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