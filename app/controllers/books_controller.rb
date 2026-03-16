class BooksController < ApplicationController
  
  def index
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
      @user = current_user
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end



private

def book_params
  params.require(:book).permit(:title, :body)
end

end