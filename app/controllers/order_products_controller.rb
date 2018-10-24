class OrderProductsController < ApplicationController

  def create
    # pull in product and quantity from form partial on product show page
    product = Product.find_by(id: params[:order_product][:product_id].to_i)
    quantity = params[:order_product][:quantity].to_i

    # create the orderproduct, add it to the current cart, and save it
    if @current_order.save && @current_order.add_product(product, quantity)
      # save the cart and update the session
      @current_order.save
      session[:order_id] = @current_order.id

      redirect_to cart_path
    else
      flash[:error] = "Error: Could not add product to cart"

      redirect_back fallback_location: products_path
    end
  end

  def update
    op = OrderProduct.find_by(id: params[:id].to_i)
    new_quantity = params[:order_product][:quantity].to_i

    if @current_order.edit_quantity(op, new_quantity) && @current_order.save
      if new_quantity == 0
        flash[:success] = "Removed #{op.product.name} from cart"
      end
      redirect_to cart_path
    else
      flash[:error] = "Error: Could not update product order"

      redirect_back fallback_location: cart_path
    end
  end

  def destroy
    op = OrderProduct.find_by(id: params[:id])
    if op.destroy
      flash[:success] = "Removed #{op.product.name} from cart"
    else
      flash[:error] = "Error: Could not remove #{op.product.name} from cart"
    end
    redirect_back fallback_location: cart_path
  end
end
