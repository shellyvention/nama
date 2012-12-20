require 'spec_helper'

describe UsersController do

  before do
    User.current = FactoryGirl.create(:admin)
  end

  describe "create" do
    let(:user) { mock_model(User).as_null_object }

    before do
      User.stub(:new).and_return(user)
    end

    it "creates a new user" do
      User.should_receive(:new).with(
        "last_name"     => "Muster",
        "first_name"    => "Peter",
        "street"        => "Musterstrasse 1",
        "postal_code"   => "8000",
        "city"          => "Zurich",
        "date_of_birth" => "01.01.1970",
        "email"         => "peter@muster.ch").and_return(user)

      post :create, :user => {
        "last_name"     => "Muster",
        "first_name"    => "Peter",
        "street"        => "Musterstrasse 1",
        "postal_code"   => "8000",
        "city"          => "Zurich",
        "date_of_birth" => "01.01.1970",
        "email"         => "peter@muster.ch"
      }
    end

    it "saves the user" do
      user.should_receive(:save)
      post :create
    end

    context "when the user saves successfully" do
      it "sets a flash[:success] message" do
        post :create
        flash[:success].should eq("User was successfully created.")
      end

      it "redirects to the Users index" do
        post :create
        response.should redirect_to(users_url)
      end
    end

    context "when the user fails to save" do
      it "assigns @user" do
        user.stub(:save).and_return(false)
        post :create
        assigns[:user].should eq(user)
      end

      it "renders the new template" do
        user.stub(:save).and_return(false)
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "index" do
    it "renders the index template" do
      get :index
      controller.should render_template("index")
    end
  end

  describe "show" do
    let(:user) { FactoryGirl.create(:user) }

    it "assigns the requested user to @user" do
      get :show, id: user
      assigns(:user).should eq(user)
    end
  end

  describe "new" do
    it "renders the new template" do
      get :new
      controller.should render_template("new")
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }

    it "assigns the requested user to @user" do
      get :edit, id: user
      assigns(:user).should eq(user)
    end
  end

  describe "update" do
    let(:user) { FactoryGirl.create(:user) }

    it "located the requested @user" do
      put :update, id: user
      assigns(:user).should eq(user)
    end

    context "when the user updates successfully" do
      it "sets activation token to nil" do
        post :update, id: user, user: { active: true }
        assigns(:user).should eq(user)
        assigns(:user).activation_token.should eq(nil)
      end

      it "sets a flash[:success] message" do
        post :update, id: user
        flash[:success].should eq("User was successfully updated.")
      end

      it "redirects to the Users index" do
        post :update, id: user
        response.should redirect_to(users_url)
      end
    end

    context "when user is not active" do
      it "sets activation token to locked" do
        post :update, id: user, user: { active: false }
        assigns(:user).should eq(user)
        assigns(:user).activation_token.should eq("locked")
      end
    end

    context "when the user fails to update" do
      it "assigns @user" do
        user.stub(:update_attributes).and_return(false)
        put :update, id: user
        assigns[:user].should eq(user)
      end

      it "renders the edit template" do
        User.stub(:find).with(user.id.to_s).and_return(user)
        user.stub(:update_attributes).and_return(false)
        put :update, id: user
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
      let(:user) { FactoryGirl.create(:user) }
      let(:organizer) { FactoryGirl.create(:organizer) }
      let(:event) { FactoryGirl.build(:event) }


    it "deletes the user" do
      User.stub(:find).with(user.id.to_s).and_return(user)
      expect {
        delete :destroy, id: user
      }.to change(User,:count).by(-1)
    end

    it "redirects to the Users index" do
      delete :destroy, id: user
      flash[:success].should eq("User was successfully deleted.")
      response.should redirect_to(users_url)
    end

    context "when the user fails to delete" do
      before do
        event.user = organizer
        event.save
      end
      it "cannot delete user" do
        delete :destroy, id: organizer
        flash[:error].should eq("Cannot delete user: User still owns events.")
        response.should render_template("show")
      end
    end
  end

  describe "create activation" do
    let(:user) { FactoryGirl.create(:user) }

    it "located the requested @user, password missing" do
      post :create_activation, email: user.email
      assigns(:user).should eq(user)
      response.should render_template("static_pages/signup")
    end

    it "located the requested @user, signup works" do
      post :create_activation, email: user.email, password: "Password-1", password_confirmation: "Password-1"
      assigns(:user).should eq(user)
      response.should redirect_to(signin_path)
    end

    it "cannot find a non-existing user" do
      post :create_activation, email: "no@email.com"
      assigns(:user).should eq(nil)
      response.should render_template("static_pages/signup")
    end
  end

  describe "activate user" do
    let(:user) { FactoryGirl.create(:user) }

    it "located the requested @user, token not right" do
      get :activate_user, user_id: user.id, activation_token: "No-Right-Token"
      assigns(:user).should eq(user)
      response.should render_template("activation_failure")
    end

    context "when the activation token is set" do
      before do
        user.activation_token = "Right-Token"
        user.save
      end
      it "located the requested @user, right token" do
        get :activate_user, user_id: user.id, activation_token: "Right-Token"
        assigns(:user).should eq(user)
        response.should redirect_to(root_url)
      end
    end
  end
end
