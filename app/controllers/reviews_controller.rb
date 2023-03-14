class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    redirect_to product_path(@product)
  end

  private
    def review_params
      params.require(:review).permit(:reviewer, :review)
    end
end
