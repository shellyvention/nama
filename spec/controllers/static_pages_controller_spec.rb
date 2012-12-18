require 'spec_helper'

describe StaticPagesController do

  describe "home admin" do
    it "calls home admin" do
      get :home_admin
      assigns(:num_members).should_not eq(nil)
      assigns(:num_groups).should_not eq(nil)
      assigns(:num_males).should_not eq(nil)
      assigns(:num_females).should_not eq(nil)
      assigns(:num_upcoming_events).should_not eq(nil)
      assigns(:num_past_events).should_not eq(nil)
    end
  end
end
