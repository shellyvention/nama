require 'spec_helper'

describe TimeslotsController do

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }
    let(:timeslot) { FactoryGirl.build(:timeslot) }

    before do
      event.user = organizer
      event.save
      timeslot.event = event
      timeslot.user = user
      timeslot.save
    end

    it "renders the index template" do
      get :index, event_id: event.id
      assigns(:event).should eq(event)
      response.should redirect_to(events_url(event))
    end
  end

  describe "create" do
    let(:user) { FactoryGirl.create(:user) }
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }

    before do
      event.user = organizer
      event.save
    end

    it "assigns @event" do
      xhr :post, :create, event_id: event.id, timeslot: {
          "start"       => "08:00",
          "finish"      => "10:00",
          "event_id"    => "1"
      }
      assigns(:event).should eq(event)
      timeslot = assigns(:event).timeslots[0]
      timeslot.start.to_s.should eq("08:00")
      timeslot.finish.to_s.should eq("10:00")
      timeslot.user.should eq(nil)
      response.should render_template("refresh")
    end
  end

  describe "destroy" do
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }
    let(:timeslot) { FactoryGirl.build(:timeslot) }

    before do
      event.user = organizer
      event.save
      timeslot.event = event
      timeslot.save
    end

    it "deletes the timeslot" do
      xhr :delete, :destroy, event_id: timeslot.event.id, id: timeslot.id
      assigns(:event).should eq(event)
      assigns(:event).timeslots.empty?.should == true
      response.should render_template("refresh")
    end
  end

  describe "duplicate" do
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }
    let(:timeslot) { FactoryGirl.build(:timeslot) }

    before do
      event.user = organizer
      event.save
      timeslot.event = event
      timeslot.save
    end

    it "duplicates a timeslot" do
      xhr :post, :duplicate, event_id: timeslot.event.id, id: timeslot.id
      assigns(:event).should eq(event)
      assigns(:event).timeslots.size.should == 2
      duplicate = assigns(:event).timeslots[1]
      duplicate.start.should eq(timeslot.start)
      duplicate.finish.should eq(timeslot.finish)
      duplicate.event.should eq(timeslot.event)
      duplicate.user.should eq(nil)
      response.should render_template("refresh")
    end
  end

  describe "enroll" do
    let(:organizer) { FactoryGirl.create(:organizer) }
    let(:event) { FactoryGirl.build(:event) }
    let(:timeslot) { FactoryGirl.build(:timeslot) }

    before do
      event.user = organizer
      event.save
      timeslot.event = event
      timeslot.save
      User.current = FactoryGirl.create(:user)
    end

    it "enrolls a user" do
      xhr :post, :enroll, event_id: timeslot.event.id, id: timeslot.id
      assigns(:event).should eq(event)
      enrolled = assigns(:event).timeslots[0]
      enrolled.user.should eq(User.current)
      response.should render_template("refresh")
    end

    context "enrollment fails" do
      before do
        User.current = nil
      end

      it "no enrollment, non-existing timeslot" do
        xhr :post, :enroll, event_id: timeslot.event.id, id: timeslot.id
        assigns(:event).should eq(event)
        flash[:error].should eq("Ups! Something went wrong. Please try again later!")
        response.should redirect_to(events_url)
      end
    end
  end
end
