class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if user.role == 1
        redirect_to users_url
      else
        redirect_to events_url
      end
    else
	  flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    User.current = user
  end

  def sign_out
    User.current = nil
    cookies.delete(:remember_token)
  end
end
