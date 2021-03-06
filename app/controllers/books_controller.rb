class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = current_user
    @user_show = @book_show.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
  end

  def index
    @books = Book.all
    @book =Book.new
    @user = current_user
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
    if @user == @book.user
      render :edit
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
