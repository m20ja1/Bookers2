class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "successfully"
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end



private

def book_params
  params.require(:book).permit(:title, :body)
end

def logged_in_user
  unless Current.user
    flash[:danger] = "ログインしてください"
    redirect_to login_path
  end
end

def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == Current.user.id
      redirect_to books_path
    end
end

end