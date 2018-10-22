class UsersController < ApplicationController
  before_action :find_merchant

  def index
    @users = User.all
    @merchants = Merchant.all #adding merchants to index for viewing and sorting in views
  end

  def new
    @user = User.new
  end

  def create; end


  def show; end

  def update
    if @user && @user.update(user_params) #(if user exists AND can be updated)
      flash[:success] = "Saved"
      redirect_to root_path
    else
      flash.now[:error] = 'Not updated.'
      render :edit
    end
  end

  def edit
    @user ||= User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :not_found, status: :not_found
    end
  end

  def destroy
    #delete account aka be sent to siberia
  end

  private

  def find_merchant
    @merchant ||= User.find_by(id: params[:id].to_i)

    if @merchant.nil?
      render :not_found
    end
  end

  def user_params
    return params.require(:user).permit(:name, :address, :email, :cc_num, :cc_csv, :cc_exp, :type, :bill_zip, :provider)
  end
end
