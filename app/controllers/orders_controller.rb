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
    @current_order.user.save # TODO: user info from form not saving
    @paid_order_number = @current_order.submit_order

    session[:order_id] = nil

    redirect_to confirmation_path(@paid_order_number), status: :success
  end
end
