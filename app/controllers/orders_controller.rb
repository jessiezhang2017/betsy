class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def cart
  end

  def checkout
  end

  def update
    @paid_order = @current_order.submit_order

    session[:order_id] = nil

    render :confirmation, status: :success
  end
end
