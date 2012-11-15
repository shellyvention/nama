require 'spec_helper'

describe "timeslots/index" do
  before(:each) do
    assign(:timeslots, [
      stub_model(Timeslot,
        :event_id => 1
      ),
      stub_model(Timeslot,
        :event_id => 1
      )
    ])
  end

  it "renders a list of timeslots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end