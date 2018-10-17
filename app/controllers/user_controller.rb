class UserController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  def edit
  end

  private

  def user_params
    return params.require(:user).permit(:name, :address, :email, :cc_num, :merchant_id)
  end
end
