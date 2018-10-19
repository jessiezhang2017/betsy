class OrderProductsController < ApplicationController

  def create
    # pull in product and quantity from form partial on product show page
    product = Product.find_by(id: params[:order_product][:product_id].to_i)
    quantity = params[:order_product][:quantity].to_i

    # create the orderproduct, add it to the current cart, and save it
    @current_order.add_product(product, quantity)

    # save the cart and update the session
    @current_order.save
    session[:order_id] = @current_order.id

    redirect_to cart_path
  end



end
