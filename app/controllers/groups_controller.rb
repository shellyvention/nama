class GroupsController < ApplicationController
  before_filter :authorize_admin

  def index
    @groups = Group.paginate(page: params[:page], :per_page => 15)
  end

  def show
    @group = Group.find(params[:id])
	@non_members = User.all - @group.users
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])

    if @group.save
	  flash[:success] = "Group was successfully created."
	  redirect_to @group
    else
	  render 'new'
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
	  flash[:success] = "Group was successfully updated."
	  redirect_to @group
    else
	  render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])

	@group.destroy
	flash[:success] = "Group was successfully deleted."
    redirect_to groups_url
  end

  def add_membership
    @group = Group.find(params[:id])
    user = User.find(params[:user_id])
	@group.users << user

	@non_members = User.all - @group.users
	render 'members'
  end

  def remove_membership
    @group = Group.find(params[:id])
    user = User.find(params[:user_id])
	@group.users.delete user

	@non_members = User.all - @group.users
	render 'members'
  end
end
