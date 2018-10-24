class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :retire]

  def index
    @products = Product.active_products
  end

  def bycategory
    id = params[:id].to_i
    @category_selected = Category.find_by(id:id)
    @products_by_category = Product.category_list(id)
  end

  def bymerchant
    id = params[:id].to_i
    @merchant_selected = User.find_by(id:id)
    @products_by_merchant = Product.merchant_list(id)
  end

  def show
    if @current_order.valid?
      @op = @current_order.order_products.find_by(product_id: params[:id])
    end
  end

  def new
    if session[:user_id]
        @product = Product.new
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
        render :new, status: :bad_request
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

  def category_params
    return params.require(:category).permit(:id)
  end
end
