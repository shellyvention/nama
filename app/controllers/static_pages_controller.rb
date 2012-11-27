class StaticPagesController < ApplicationController
  def signup
  end

  def help
  end

  def about
  end

  def contact
  end

  def create_activation
    @user = User.find_by_email(params[:email])

    if @user && @user.signup(params[:password], params[:password_confirmation])
      redirect_to signin_path
    else
      render 'signup'
    end
  end

  def activate_user
    @user = User.find_by_id(params[:user_id])

    if @user && @user.activate(params[:activation_token])
      redirect_to root_url
    else
      render 'activation_failure'
    end
  end
end
