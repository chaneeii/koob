class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = current_user.requests.create(request_params)

    redirect_to @request.book
  end

  private
    def request_params
      params.require(:request).permit(:start_date, :end_date, :status , :request_msg, :book_id)
    end

end