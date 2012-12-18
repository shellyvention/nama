# == Schema Information
#
# Table name: timeslots
#
#  id         :integer          not null, primary key
#  start      :time
#  finish     :time
#  event_id   :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Timeslot do

  let(:user) { FactoryGirl.create(:user) }
  let(:organizer) { FactoryGirl.create(:organizer) }

  before do
    @event = Event.create(
      name: "MyEvent",
      description: "MyDescr",
      user_id: organizer.id,
      date: "2012-12-18")

    @timeslot = Timeslot.new(
      start: "2000-01-01 08:00:00",
      finish: "2000-01-01 10:00:00")

    @timeslot.event = @event
  end

  subject { @timeslot }

  describe "user enrollment" do
    before do
      User.current = organizer
    end
    it "should work" do
      @timeslot.can_enroll?.should == true
    end
  end

  describe "user enrollment" do
    before do
      @timeslot.user = user
    end
    it "should not work" do
      @timeslot.can_enroll?.should == false
    end
  end

  describe "calculate stars" do
    before do
      @timeslot.user = user
      @timeslot.save
    end
    it "should work" do
      Timeslot.calculate_stars_max(user, @event).should eq(3)
    end
  end

  describe "enroll" do
    it "should work" do
      @timeslot.enroll(@event, user, organizer).should == true
    end

    context "error" do
      before do
        @timeslot.start = nil
      end
      it "should not work" do
        @timeslot.enroll(@event, user, organizer).should == false
      end
    end
  end

end
