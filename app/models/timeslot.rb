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

  def can_enroll?
    return false unless user.nil?

    list = Timeslot.joins(:event).where(
      "events.date = :date AND timeslots.user_id = :user_id AND :to >= \"from\" AND \"to\" >= :from",
      date: event.date, user_id: User.current.id, to: to, from: from)

    list.empty?
  end

  def self.calculate_stars_max(user, event)
    Timeslot.where(
      user_id: user.is_a?(User) ? user.id : user,
      event_id: event.id).count * 3
  end
end
