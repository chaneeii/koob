class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    book = @review.book
    redirect_to book
  end

  def destroy
    @review = Review.find(params[:id])
    book = @review.book
    @review.destroy

    redirect_to book
  end


  private
    def review_params
      params.require(:review).permit(:comment, :star, :book_id)
    end
end