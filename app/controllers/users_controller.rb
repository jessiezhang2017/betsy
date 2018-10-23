class UsersController < ApplicationController
  before_action :find_merchant, except: [:index, :edit, :create, :show]
  before_action :find_any_user, only: [:show, :edit, :destroy]
  # before_action :find_user

  def index
    @merchants = Merchant.all #adding merchants to index for viewing and sorting in views
    # @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    redirect_to user_path(@current_user.id) #do not go to create page
  end

  def show; end

  def update
    if @current_user && @current_user.update(user_params)
      flash[:success] = "Saved"
      redirect_to root_path
    else
      flash.now[:error] = 'Not updated.'
      render :edit
    end
  end

  def edit; end

  def destroy
    unless @user.nil?
      @user.destroy
      flash[:success] = "#{@current_user.name} deleted"
      redirect_to root_path
    end
  end

  private

  def find_any_user
    @user ||= User.find_by(id: params[:id].to_i)

    if @user.nil?
      flash[:warning] = "No such user"
    end
  end

  def find_merchant
    @merchant ||= User.find_by(id: params[:id].to_i, type: "Merchant")

    if @merchant.nil?
      render :not_found
    end
  end

  def user_params
    return params.require(:user).permit(:name, :address, :email, :cc_num, :cc_csv, :cc_exp, :type, :bill_zip, :provider)
  end
end
