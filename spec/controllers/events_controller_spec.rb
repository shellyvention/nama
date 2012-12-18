require 'spec_helper'

describe EventsController do

  before do
    User.current = FactoryGirl.create(:admin)
  end

  describe "create" do
    let(:event) { mock_model(Event).as_null_object }

    before do
      Event.stub(:new).and_return(event)
    end

    it "creates a new event" do
      Event.should_receive(:new).with(
        "name"          => "MyEvent",
        "description"   => "MyDescr",
        "user_id"       => "1",
        "date"          => "2012-12-18").and_return(event)

      post :create, :event => {
        "name"          => "MyEvent",
        "description"   => "MyDescr",
        "user_id"       => "1",
        "date"          => "2012-12-18"
      }
    end

    it "saves the event" do
      event.should_receive(:save)
      post :create
    end

    context "when the event saves successfully" do
      it "sets a flash[:success] message" do
        post :create
        flash[:success].should eq("Event was successfully created.")
      end

      it "redirects to the @event" do
        post :create
        response.should redirect_to(event)
      end
    end

    context "when the event fails to save" do
      it "assigns @event" do
        event.stub(:save).and_return(false)
        post :create
        assigns[:event].should eq(event)
      end

      it "renders the new template" do
        event.stub(:save).and_return(false)
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let(:eventUpcoming) { FactoryGirl.build(:event) }
    let(:eventPast) { FactoryGirl.build(:event) }

    before do
      eventUpcoming.user = user
      eventUpcoming.date = Date.today + 1
      eventUpcoming.save
      eventPast.user = user
      eventPast.date = Date.today - 1
      eventPast.save
    end

    it "renders the index template" do
      get :index
      upcoming = assigns(:events_upcoming)
      upcoming[0].should eq(eventUpcoming)
      past = assigns(:events_past)
      past[0].should eq(eventPast)
      controller.should render_template("index")
    end
  end

  describe "show" do
    let(:event) { FactoryGirl.build(:event) }
    let(:organizer) { FactoryGirl.create(:organizer) }

    before do
      event.user = organizer
      event.save
    end

    it "assigns the requested event to @event" do
      get :show, id: event
      assigns(:event).should eq(event)
    end
  end

  describe "new" do
    it "renders the new template" do
      get :new
      controller.should render_template("new")
    end
  end

  describe "edit" do
    let(:event) { FactoryGirl.build(:event) }
    let(:organizer) { FactoryGirl.create(:organizer) }

    before do
      event.user = organizer
      event.save
    end

    it "assigns the requested event to @event" do
      get :edit, id: event
      assigns(:event).should eq(event)
    end
  end

  describe "update" do
    let(:event) { FactoryGirl.build(:event) }
    let(:organizer) { FactoryGirl.create(:organizer) }

    before do
      event.user = organizer
      event.save
    end

    it "located the requested @event" do
      put :update, id: event
      assigns(:event).should eq(event)
    end

    context "when the event updates successfully" do
      it "sets a flash[:success] message" do
        post :update, id: event
        flash[:success].should eq("Event was successfully updated.")
      end

      it "redirects to the Events index" do
        post :update, id: event
        response.should redirect_to(event)
      end
    end

    context "when the event fails to update" do
      it "assigns @eventr" do
        event.stub(:update_attributes).and_return(false)
        put :update, id: event
        assigns[:event].should eq(event)
      end

      it "renders the edit template" do
        Event.stub(:find).with(event.id.to_s).and_return(event)
        event.stub(:update_attributes).and_return(false)
        put :update, id: event
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }

    before do
      event.user = organizer
      event.save
    end

    it "deletes the event" do
      Event.stub(:find).with(event.id.to_s).and_return(event)
      expect {
        delete :destroy, id: event
      }.to change(Event,:count).by(-1)
    end

    it "redirects to the Events index" do
      delete :destroy, id: event
      flash[:success].should eq("Event was successfully deleted.")
      response.should redirect_to(events_url)
    end
  end
end
