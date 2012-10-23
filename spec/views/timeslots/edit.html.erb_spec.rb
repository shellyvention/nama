require 'spec_helper'

describe "timeslots/edit" do
  before(:each) do
    @timeslot = assign(:timeslot, stub_model(Timeslot,
      :event_id => 1
    ))
  end

  it "renders the edit timeslot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => timeslots_path(@timeslot), :method => "post" do
      assert_select "input#timeslot_event_id", :name => "timeslot[event_id]"
    end
  end
end
