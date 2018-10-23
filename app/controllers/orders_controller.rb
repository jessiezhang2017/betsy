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
    @current_order.update(order_user_params)
    @current_order.submit_order

    session[:paid_order_id] = session[:order_id]
    session[:order_id] = nil

    redirect_to confirmation_path, status: :success
  end

  def confirmation
    @paid_order = Order.find_by(id: session[:paid_order_id])
    session[:paid_order_id] = nil
  end

  private

    def order_user_params
      return params.require(:order).permit(user_attributes: [:id, :name, :address, :email, :cc_num, :cc_csv, :cc_exp, :bill_zip])
    end
end
