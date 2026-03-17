class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  
  def index
    @users = User.all
    @book = Book.new
  end

  def new
    @user = User.new
  end

  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(user), notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end

  
  private
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end


end
