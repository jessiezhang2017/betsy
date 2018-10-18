class ProductsController < ApplicationController

  def index
    @products = Product.all
    @products_by_category = Product.product_by_category
    @pruducts_by_merchant = Product.product_by_merchant
  end

  def show
     Product

  end

  def new


  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
