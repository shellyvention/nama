require 'spec_helper'

describe "timeslots/new" do
  before(:each) do
    assign(:timeslot, stub_model(Timeslot,
      :event_id => 1
    ).as_new_record)
  end

  it "renders new timeslot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => timeslots_path, :method => "post" do
      assert_select "input#timeslot_event_id", :name => "timeslot[event_id]"
    end
  end
end
