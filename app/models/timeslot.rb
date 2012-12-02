# == Schema Information
#
# Table name: timeslots
#
#  id         :integer          not null, primary key
#  from       :time
#  to         :time
#  event_id   :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Timeslot < ActiveRecord::Base
  attr_accessible :event_id, :from, :to

  belongs_to :event
  belongs_to :user

  validates :from, presence: true
  validates :to, presence: true
  validates :event_id, presence: true
end
