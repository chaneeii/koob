class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.book
  end

  def destroy
    @review = Review.find(params[:id])
    book = @review.book
    @review.destroy

    redirect_to book
  end


  private
    def review_params
      params.require(:review).permit(:comment, :star, :room_id)
    end
end