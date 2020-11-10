class BooksController < ApplicationController

  # only이후 메소드에서 뭘 하든 먼저 setbook메소드 호출
  before_action :set_book, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:photo_upload]

  def index
    # 현재 유저의 책 전체 다 보여줌
    @books = current_user.books
  end

  def photo_upload
    @photos = @book.photos
  end


  def show
    @photos = @book.photos
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      if params[:images]
        params[:images].each do |image|
          @book.photos.create(image: image)
        end
      end
      @photos = @book.photos
      redirect_to edit_book_path(@book), notice: "도서를 등록합니다 :) "
    else
      render :new
    end
  end

  def edit
    if current_user.id == @book.user.id
      @photos = @book.photos
    else
      redirect_to root_path, notice: "접근 권한이 없습니다."
    end
  end

  def update
    if @book.update(book_params)

      if params[:images]
        params[:images].each do |image|
          @book.photos.create(image: image)
        end
      end

      redirect_to edit_book_path(@book), notice: "업데이트합니다 :) "
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
    params.require(:book).permit(:book_type, :isbn, :book_name, :summary, :address, :active, :images)
  end

end