class RequestsController < ApplicationController
  before_action :authenticate_user!

  def preload
    # 1: get the book
    book = Book.find(params[:book_id])
    # 2 : get all requests of that book (>=today) 오늘 이후로만
    #   ex1 -11월 16일 ~ 11월 20일
    #  ex2 - 11월 24일 ~ 11월 29일
    today = Date.today
    requests = book.requests.where("start_date >= ? OR end_date >= ?", today, today)
    # 3 : return those requests to the datepicker
    render json: requests
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
        conflict: is_conflict(start_date, end_date)
    }
    render json: output
  end

  def create
    @request = current_user.requests.create(request_params)

    redirect_to @request.book, notice: "대여 요청이 성공적으로 전송되었습니다."
  end

  def my_requests
    @my_requests = current_user.requests
  end

  def rec_requests
    @books = current_user.books
  end

  # show forms
  def show_requests(request)
    @request = Request.find(params[:id])
  end


  private
    def is_conflict(start_date, end_date)
      book = Book.find(params[:book_id])

      check = book.requests.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def request_params
      params.require(:request).permit(:start_date, :end_date, :status , :request_msg, :book_id)
    end

  end