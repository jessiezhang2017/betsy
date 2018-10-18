class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :new, :create]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
  end

  def edit; end

  def update
  end

  def destroy
  end

  private

    def product_params
      return params.require(:product).permit(:name, :price, :category, :description, :merchant, :stock, :photo_url)
    end

    def find_product
      @product = Product.find_by(id: params[:id].to_i)

      if @product.nil?
        render :notfound, status: :not_found
      end
    end
end
