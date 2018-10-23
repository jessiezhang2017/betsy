module ApplicationHelper

# private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def format_money(price)
    return sprintf("$%.2f", price)
  end

  def format_date(date)
    return date.strftime("%A, %b %d")
  end
end
