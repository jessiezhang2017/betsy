class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    @products_by_category = Product.to_category_hash.in_stock
    @pruducts_by_merchant = Product.to_merchant_hash.in_stock

  end

  def show


  end

  def new
    @product = Product.new

  end


  def create

  end

  def edit

  end

  def update

  end

  def destroy



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
