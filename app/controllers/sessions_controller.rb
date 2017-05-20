class SessionsController < ApplicationController
  before_action :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:phone_number], params[:login_pin])
    if authorized_user
      if params[:remember_me]
        cookies.permanent[:auth_token] = authorized_user.auth_token
      else
        cookies[:auth_token] = authorized_user.auth_token
      end
      flash[:notice] = "Successfully logged in."
      redirect_to incomes_path
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      redirect_to sessions_login_path
    end
  end

  def home
  end

  def profile
  end

  def setting
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, flash[:notice] => "Logged out!"
  end
end
