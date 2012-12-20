require "spec_helper"

describe TimeslotsController do
  describe "routing" do

    it "routes to #index" do
      get("/events/3/timeslots").should route_to("timeslots#index", event_id: "3")
    end

    it "routes to #new" do
      get("/events/3/timeslots/new").should route_to("timeslots#new", event_id: "3")
    end

    it "routes to #show" do
      get("events/3/timeslots/1").should route_to("timeslots#show", event_id: "3", id: "1")
    end

    it "routes to #edit" do
      get("/events/3/timeslots/1/edit").should route_to("timeslots#edit", event_id: "3", id: "1")
    end

    it "routes to #create" do
      post("/events/3/timeslots").should route_to("timeslots#create", event_id: "3")
    end

    it "routes to #update" do
      put("/events/3/timeslots/1").should route_to("timeslots#update", event_id: "3", id: "1")
    end

    it "routes to #destroy" do
      delete("/events/3/timeslots/1").should route_to("timeslots#destroy", event_id: "3", id: "1")
    end

    it "routes to #duplicate" do
      post("/events/3/timeslots/1/duplicate").should route_to("timeslots#duplicate", event_id: "3", id: "1")
    end

    it "routes to #enroll" do
      post("/events/3/timeslots/1/enroll").should route_to("timeslots#enroll", event_id: "3", id: "1")
    end
  end
end
