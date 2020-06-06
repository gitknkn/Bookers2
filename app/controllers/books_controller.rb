class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    
  end

  def  index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 本を投稿する際に、Book.new(book_params)※:title, :bodyは保存される
    # @book.user_id = current_user.id 
    # はBookカラムにあるuser_idとcurrent_user.idを一致させないと
    # user_id(1)が

    if @book.save
      flash[:success] = "successfully!!"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id]) 
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id]) 
    if @book.user != current_user
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "successfully!!"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book
    @book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
