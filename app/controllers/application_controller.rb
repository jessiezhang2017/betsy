class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :current_order

  def current_order
    if session[:order_id]
      @current_order = Order.find_by(id: session[:order_id].to_i)
    else
      @current_order = generate_cart
    end
  end

  private

  def find_user
    @current_user ||= User.find_by(id: session[:user_id])

  end

  def generate_cart
    order = Order.new(status: "pending")
    if find_user
      order.user_id = find_user.id
    else
      user = User.create(name: "sovietski-guest", uid: (User.last.id + 1), provider: "sovietski")
      order.user_id = user.id
    end
    return order
  end

end
