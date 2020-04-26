class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    # @book = @user.book.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = "successfully!!"
       redirect_to user_path(@user.id)
    else 
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end


private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
