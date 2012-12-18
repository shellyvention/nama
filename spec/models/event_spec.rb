# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Event do

  let(:organizer) { FactoryGirl.create(:organizer) }

  before do
    @event = Event.new(
      name: "MyEvent",
      description: "MyDescr",
      user_id: organizer.id,
      date: "2012-12-18")
  end

  subject { @event }
end
