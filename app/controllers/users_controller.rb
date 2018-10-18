class UsersController < ApplicationController
  #before_action is type merchant?

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end


  def show
  end

  def update
    #can become merchant?
  end

  def edit
    #can become merchant?
  end

  def destroy
    #delete account aka be sent to siberia
  end

  private

  def user_params
    return params.require(:user).permit(:name, :address, :email, :cc_num, :cc_csv, :cc_exp, :type, :bill_zip, :provider)
  end
end
