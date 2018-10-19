class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :current_order

  def current_order
    if session[:order_id]
      @current_order = Order.find_by(id: session[:order_id].to_i)
    else
      @current_order = Order.create(status: "shopping")
      session[:order_id] = @current_order.id
    end
    return @current_order
  end

  private

  def find_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
