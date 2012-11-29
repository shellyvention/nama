class UsersController < ApplicationController
  before_filter :authorize_admin, except: [:create_activation, :activate_user]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.password = @user.password_confirmation = "default"

    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to users_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "User was successfully updated."
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    flash[:success] = "User was successfully deleted."
    redirect_to users_url

  rescue ActiveRecord::DeleteRestrictionError
    flash[:error] = "Cannot delete user: User still owns events."
    render 'show'
  end

  def create_activation
    @user = User.find_by_email(params[:email])

    if @user && @user.signup(params[:password], params[:password_confirmation])
      redirect_to signin_path
    else
      render 'static_pages/signup'
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
