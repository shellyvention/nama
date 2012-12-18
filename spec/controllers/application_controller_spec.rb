require 'spec_helper'

describe ApplicationController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:organizer) { FactoryGirl.create(:organizer) }

  describe "setup user" do
    controller do
      before_filter :setup_user

      def index
        render nothing: true
      end
    end

    context "cookie not set" do
      before do
        User.current = nil
        cookies[:remember_token] = nil
      end

      it "should not set User.current" do
        get :index
        User.current.should eq(nil)
      end
    end

    context "cookie set" do
      before do
        User.current = nil
        cookies[:remember_token] = user.remember_token
      end

      it "should set User.current" do
        get :index
        User.current.should eq(user)
      end
    end
  end

  describe "signed_in_user" do
    controller do
      before_filter :signed_in_user

      def index
        render nothing: true
      end
    end

    context "not signed in" do
      before do
        User.current = nil
      end

      it "should redirect to login" do
        get :index
        response.should redirect_to(signin_url)
      end
    end

    context "signed in" do
      before do
        User.current = user
      end

      it "should render the index" do
        get :index
        response.status.should == 200
      end
    end
  end

  describe "authorize_admin" do
    controller do
      before_filter :authorize_admin

      def index
        render nothing: true
      end
    end

    context "not signed in" do
      before do
        User.current = nil
      end

      it "should redirect to login" do
        get :index
        response.should redirect_to(signin_url)
      end
    end

    context "signed in as admin" do
      before do
        User.current = admin
      end

      it "should render the index" do
        get :index
        response.status.should == 200
      end
    end

    context "signed in as user" do
      before do
        User.current = user
      end

      it "should render the index" do
        get :index
        response.should render_template("static_pages/error")
      end
    end
  end

  describe "authorize_organizer" do
    controller do
      before_filter :authorize_organizer

      def index
        render nothing: true
      end
    end

    context "not signed in" do
      before do
        User.current = nil
      end

      it "should redirect to login" do
        get :index
        response.should redirect_to(signin_url)
      end
    end

    context "signed in as organizer" do
      before do
        User.current = organizer
      end

      it "should render the index" do
        get :index
        response.status.should == 200
      end
    end

    context "signed in as admin" do
      before do
        User.current = admin
      end

      it "should render the index" do
        get :index
        response.status.should == 200
      end
    end

    context "signed in as user" do
      before do
        User.current = user
      end

      it "should render the index" do
        get :index
        response.should render_template("static_pages/error")
      end
    end
  end
end
