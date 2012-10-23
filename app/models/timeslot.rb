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

class Timeslot < ActiveRecord::Base
  attr_accessible :event_id, :from, :to

  belongs_to :event

  validates :from, presence: true
  validates :to, presence: true
  validates :event_id, presence: true
  
end
