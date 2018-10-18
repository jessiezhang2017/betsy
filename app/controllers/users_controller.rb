class UsersController < ApplicationController
  before_action :find_user
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

  def find_user
    id = params[:id].to_i
    @user = User.find_by(id: id)

    if @user.nil?
      flash.now[:warning] = "Imposter!"
     # render :not_found
    end
  end

  def user_params
    return params.require(:user).permit(:name, :address, :email, :cc_num, :cc_csv, :cc_exp, :type, :bill_zip)
  end
end
