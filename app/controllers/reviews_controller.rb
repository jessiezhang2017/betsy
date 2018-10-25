class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    product = Product.find_by(params[:id])
    if @current_user.is_a_merchant?
      if @current_user .id != product.user_id
         review = product.reviews.new(review_params)
      end

      if review.save
        flash[:success] = 'Review Created!'
        redirect_to product_path(id: product.id)
      else
        flash.now[:warning] = 'Review not created!'
        render :new, status: :bad_request
      end
    end
  end

end
