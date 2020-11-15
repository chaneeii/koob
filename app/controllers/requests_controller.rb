class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = current_user.requests.create(request_params)

    redirect_to @request.book, notice: "대여 요청이 성공적으로 전송되었습니다."
  end

  private
    def request_params
      params.require(:request).permit(:start_date, :end_date, :status , :request_msg, :book_id)
    end

end