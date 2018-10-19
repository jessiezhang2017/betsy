require 'pry'

class OrderProductsController < ApplicationController

  def create
    product = Product.find_by(id: params[:order_product][:product_id].to_i)
    quantity = params[:order_product][:quantity].to_i

    @current_order.add_product(product, quantity)
    # check quantity against stock?

    redirect_to cart_path
  end



end
