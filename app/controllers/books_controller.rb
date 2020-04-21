class BooksController < ApplicationController

  def new
  end

  def  index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "successfully!!"
      redirect_to books_path
    else
      render :index
      @book = Book.new
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id]) 
  end

  def update

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

end

