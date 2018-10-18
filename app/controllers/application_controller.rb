class ApplicationController < ActionController::Base
  before_action :find_user

  private

  def find_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

end
