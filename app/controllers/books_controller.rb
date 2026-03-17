class BooksController < ApplicationController
  before_action :logged_in_user
  
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end



private

def book_params
  params.require(:book).permit(:title, :body)
end

def logged_in_user
  unless current_user
    flash[:danger] = "ログインしてください"
    redirect_to new_session_path
  end
end

end