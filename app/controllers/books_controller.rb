class BooksController < ApplicationController

  # only이후 메소드에서 뭘 하든 먼저 setbook메소드 호출
  before_action :set_book, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]


  def index
    # 현재 유저의 책 전체 다 보여줌
    @books = current_user.books
  end

  def show
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book, notice: "Saved..."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Updated.."
    else
      render :edit
    end
  end

  # 아이디 알아야함
  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:book_type, :isbn, :book_name, :summary, :address, :active)
    end

end
