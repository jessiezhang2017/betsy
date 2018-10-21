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
    if params[:user_id]
      @user_id = params[:user_id].to_i
      user = User.find_by(id: @user_id)
      if user.nil?
        flash.now[:warning] = "That user doesn't exit"
      end
      @product.user_id = @user_id

    end
  end


  def create
      @user_id = session[:uer_id].to_i
      merchant = Merchant.find_by(id: @user_id)

      if merchant.nil?
        flash.now[:danger] = 'Not a merchant!'
        redirect_to products_path
      else
        @product = Product.new(product_params)
        product.user = merchant
        if @product.save
           flash[:success] = 'Product Created!'
           redirect_to products_path
        else
           flash.now[:danger] = 'Product not created!'
           render :new, status: :bad_request
        end
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
    unless @product.nil?
      @product.destroy
      flash[:success] = "#{@product.name} deleted"
      redirect_to root_path
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
    return params.require(:product).permit(:name, :category_id, :price, :description, :stock, :photo_url)
  end

end
