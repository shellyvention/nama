# == Schema Information
#
# Table name: timeslots
#
#  id         :integer          not null, primary key
#  from       :time
#  to         :time
#  event_id   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Timeslot do
  pending "add some examples to (or delete) #{__FILE__}"
end
