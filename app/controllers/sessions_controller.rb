class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: auth_hash[:uid], name: auth_hash[:name], provider: 'github')
    if @user
      flash[:success] = "Welcome back #{@user.name}"
    else
      #try to make a new user
      @user = User.build_from_github(auth_hash)
      if @user.save
        flash[:success] = "Welcome #{@user.name}"
        redirect_to edit_user_path(@user.id)
        #would you like to register as a merchant?
      else
        flash[:error] = "Could not create account: #{@user.errors.messages}"
        redirect_to root_path
        return
      end
    end
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Bye!"

    redirect_to root_path
  end
end
