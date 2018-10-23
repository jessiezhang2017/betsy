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
    paid_order_number = @current_order.id

    session[:order_id] = nil

    redirect_to confirmation_path(paid_order_number), status: :success
  end

  def confirmation
    @paid_order = Order.find_by(id: params[:id].to_i)
  end

  private

    def order_user_params
      return params.require(:order).permit(user_attributes: [:id, :name, :address, :email, :cc_num, :cc_csv, :cc_exp, :bill_zip])
    end
end
