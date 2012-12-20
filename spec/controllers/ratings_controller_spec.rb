require 'spec_helper'

describe RatingsController do
  let(:organizer) { FactoryGirl.create(:organizer) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.build(:event) }
  let(:timeslot) { FactoryGirl.build(:timeslot) }
  let(:rating) { FactoryGirl.build(:rating) }

  before do
    event.user = organizer
    event.save
    timeslot.event = event
    timeslot.user = user
    timeslot.save
  end

  describe "show event rating" do
    it "shows the event rating" do
      get :show_event_rating, event_id: event.id
      assigns(:event).should eq(event)
      assigns(:users)[0].should eq(user)
      rating = assigns(:ratings)[user.id]
      rating.stars_max.should eq(3)
      controller.should render_template("show_event_rating")
    end
  end

  describe "update event rating" do
    it "creates a new rating" do
      put :update_event_rating, event_id: event.id, rating: {
        user.id => { stars: 2, stars_extra: 1 }
      }
      rating = Rating.user_event_rating(user.id, event.id).first
      rating.stars.should eq(2)
      rating.stars_max.should eq(3)
      rating.stars_extra.should eq(1)
      response.should redirect_to(events_url)
    end

    context "when a rating exists" do
      before do
        rating.event = event
        rating.user = user
        rating.save
      end

      it "updates a rating" do
        put :update_event_rating, event_id: event.id, rating: {
          user.id => { stars: 2, stars_extra: 1 }
        }
        rating = Rating.user_event_rating(user.id, event.id).first
        rating.stars.should eq(2)
        rating.stars_max.should eq(3)
        rating.stars_extra.should eq(1)
        response.should redirect_to(events_url)
      end
    end
  end

  describe "index" do
    it "renders the index template" do
      get :index
      controller.should render_template("index")
    end
  end
end
