# == Schema Information
#
# Table name: timeslots
#
#  id         :integer          not null, primary key
#  from       :time
#  to         :time
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'spec_helper'

describe Timeslot do
  pending "add some examples to (or delete) #{__FILE__}"
end
