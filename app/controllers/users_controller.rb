class UsersController < ApplicationController
  before_action :find_user
  #before_action is type merchant?

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    #if merchant checked, type is filled (in forms), otherwise it is not -- passive method

  auth_hash = request.env['omniauth.auth']
  user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # render :new
      # User doesn't match anything in the DB
      # TODO: Attempt to create a new user
    end

  # session[:user_id] = user.id
  redirect_to users_path
  end
  # @user = User.new(user_params)
  #   if @user.save
  #     flash[:success] = 'Success'
  #     redirect_to root_path
  #   else
  #     flash.now[:error] = 'No success'
  #     @user.errors.messages.each do |field, messages|
  #       flash.now[field] = messages
  #     end
  #   end




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
