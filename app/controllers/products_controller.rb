class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    # @products_by_category = Product.to_category_hash.in_stock
    # @pruducts_by_merchant = Product.to_merchant_hash.in_stock

  end

  def show
    @op = @current_order.order_products.new

  end

  def new
    @product = Product.new
    if session[:user_id]
      if @current_user.type == "Merchant"
        flash.now[:warning] = "That Merchant doesn't exit"
      else
      @product =@current_user.products.new
      end
    end
  end


  def create

    if session[:user_id] && @current_user.type == "Merchant"
      user = User.find_by(id: @current_user.id)
      product = user.products.new(product_params)
      product.user_id = @current_user.id

      if @product.save
        flash[:success] = 'Product Created!'
        redirect_to product_path(id: product.id)
      else
        flash.now[:danger] = 'Product not created!'
        render :new
      end
    else
      flash.now[:danger] = 'Not a Merchant!'
      render :new
    end
  end


  def edit; end

  def update
    if @product && @product.update(product_params)
      redirect_to product_path(@product.id)
    elsif @product
      render :edit, status: :bad_request
    end
  end

  def destroy

      @product.status = flase
      if @product.save
         flash[:success] = "#{@product.name} retired"
         redirect_to products_path
      else
         lash[:warning] = "#{@product.name} is not retired"
      end

  end

  private
  def find_product
    @product = Product.find_by(id: params[:id].to_i)

    if @product.nil?
      flash.now[:danger] = "Cannot find the product #{params[:id]}"
      render :notfound, status: :not_found
    end
  end

  def product_params
    return params.require(:product).permit(:name, :category_id, :price, :description, :stock, :photo_url, :status)
  end

end
