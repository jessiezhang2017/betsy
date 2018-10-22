class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :retire]

  def index
    @products = Product.active_products

  end

  def bycategory
    @products_by_category = Product.to_category_hash
  end

  def bymerchant
    @products_by_merchant = Product.to_merchant_hash
  end

  def show
    @op = @current_order.order_products.new

  end

  def new
    @product = Product.new
    if session[:user_id]
        @product = @current_user.products.new
    end
  end


  def create

    if session[:user_id]

      product = @current_user.products.new(product_params)

      if @current_user.save
        flash[:success] = 'Product Created!'
        redirect_to product_path(id: product.id)
      else
        flash.now[:danger] = 'Product not created!'
        render :new
      end
    else
      flash.now[:danger] = 'Not a Merchant!'

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

  def retire

      @product.status = false
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

  def find_merchant
    @merchant = Merchant.find_by(id: session[:user_id].to_i)
    if @merchant.nil?
      flash.now[:danger] = "Cannot find the merchant #{session[:user_id]}"
      render :notfound, status: :not_found
    end
  end

  def product_params
    return params.require(:product).permit(:name, :category_id, :price, :description, :stock, :photo_url)
  end

end
