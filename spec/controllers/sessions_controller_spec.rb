require 'spec_helper'

describe SessionsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:inactive) { FactoryGirl.create(:inactive) }

  describe "new" do
    context "not logged in" do
      before do
        User.current = nil
      end

      it "renders the new template" do
        get :new
        response.should render_template("new")
      end
    end

    context "logged in user" do
      before do
        User.current = user
      end

      it "redirects to home_user" do
        get :new
        response.should redirect_to(home_user_url)
      end

    end

    context "logged in admin" do
      before do
        User.current = admin
      end

      it "redirects to home_admin" do
        get :new
        response.should redirect_to(home_admin_url)
      end
    end
  end

  describe "create" do
    before  do
      User.current = nil
    end

    context "admin" do
      it "redirects to home_admin" do
        post :create, session: { email: admin.email, password: "ThePassword-1" }
        response.should redirect_to(home_admin_url)
        User.current.should eq(admin)
      end
    end

    context "user" do
      it "redirects to home_user" do
        post :create, session: { email: user.email, password: "ThePassword-1" }
        response.should redirect_to(home_user_url)
        User.current.should eq(user)
      end
    end

    context "inactive" do
      it "rendes the new template with error" do
        post :create, session: { email: inactive.email, password: "ThePassword-1" }
        flash[:error].should eq("Your user account is disabled.
          Please contact the administrator.")
        response.should render_template("new")
        User.current.should eq(nil)
      end
    end

    context "user does not exist" do
      it "rendes the new template with error" do
        post :create, session: { email: 'not@existing.com' }
        flash[:error].should eq("Invalid email/password combination.")
        response.should render_template("new")
      end
    end
  end

  describe "destroy" do
    before do
      User.current = user
    end

    it "signs out" do
      delete :destroy
      response.should redirect_to(root_url)
      User.current.should eq(nil)
    end
  end
end
