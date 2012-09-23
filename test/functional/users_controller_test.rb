require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { date_of_birth: @user.date_of_birth, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, phone_landline: @user.phone_landline, phone_mobile: @user.phone_mobile, postal_code: @user.postal_code, street: @user.street }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { date_of_birth: @user.date_of_birth, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, phone_landline: @user.phone_landline, phone_mobile: @user.phone_mobile, postal_code: @user.postal_code, street: @user.street }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
