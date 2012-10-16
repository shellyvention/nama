require 'spec_helper'

describe GroupsController do

  describe "create" do
    let(:group) { mock_model(Group).as_null_object }

    before do
      Group.stub(:new).and_return(group)
    end

    it "creates a new group" do
      Group.should_receive(:new).with("name" => "Herren 1").and_return(group)
      post :create, :group => { "name" => "Herren 1" }
    end

    it "saves the group" do
      group.should_receive(:save)
      post :create
    end

    context "when the group saves successfully" do
      it "sets a flash[:success] message" do
        post :create
        flash[:success].should eq("Group was successfully created.")
      end

      it "redirects to created group" do
        post :create
        response.should redirect_to(group)
      end
    end

    context "when the group fails to save" do
      it "assigns @group" do
        group.stub(:save).and_return(false)
        post :create
        assigns[:group].should eq(group)
      end

      it "renders the new template" do
        group.stub(:save).and_return(false)
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
    let(:group) { FactoryGirl.create(:group) }

    it "assigns the requested group to @group" do
      get :show, id: group
      assigns(:group).should eq(group)
    end
  end

  describe "new" do
    it "renders the new template" do
      get :new
      controller.should render_template("new")
    end
  end

  describe "edit" do
    let(:group) { FactoryGirl.create(:group) }

    it "assigns the requested group to @group" do
      get :edit, id: group
      assigns(:group).should eq(group)
    end
  end

  describe "update" do
    let(:group) { FactoryGirl.create(:group) }

    it "located the requested @group" do
      put :update, id: group
      assigns(:group).should eq(group)
    end

    context "when the group updates successfully" do
      it "sets a flash[:success] message" do
        post :update, id: group
        flash[:success].should eq("Group was successfully updated.")
      end

      it "redirects to the Groups index" do
        post :update, id: group
        response.should redirect_to(group)
      end
    end

    context "when the group fails to update" do
      it "assigns @group" do
        group.stub(:update_attributes).and_return(false)
        put :update, id: group
        assigns[:group].should eq(group)
      end

      it "renders the edit template" do
        Group.stub(:find).with(group.id.to_s).and_return(group)
        group.stub(:update_attributes).and_return(false)
        put :update, id: group
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    let(:group) { FactoryGirl.create(:group) }

    it "deletes the group" do
      Group.stub(:find).with(group.id.to_s).and_return(group)
      expect {
        delete :destroy, id: group
      }.to change(Group,:count).by(-1)
    end

    it "redirects to the Groups index" do
      delete :destroy, id: group
      response.should redirect_to(groups_url)
    end
  end

  describe "add_membership" do
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:user) }

    it "adds a member" do
      expect {
        xhr :post, :add_membership, id: group, user_id: user.id
      }.to change(GroupMember, :count).by(1)

      response.should render_template("members")
    end
  end

  describe "remove_membership" do
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      group.users << user
    end

    it "removes a member" do
      expect {
        xhr :delete, :remove_membership, id: group, user_id: user.id
      }.to change(GroupMember, :count).by(-1)

      response.should render_template("members")
    end
  end
end
