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

class Timeslot < ActiveRecord::Base
  attr_accessible :event_id, :start, :finish, :user_id

  belongs_to :event
  belongs_to :user

  validates :start, presence: true
  validates :finish, presence: true
  validates :event_id, presence: true

  def can_enroll?
    return false unless user.nil?

    list = Timeslot.joins(:event).where(
      "events.date = :date AND timeslots.user_id = :user_id AND :finish >= start AND finish >= :start",
      date: event.date, user_id: User.current.id, finish: finish, start: start)

    list.empty?
  end

  def self.calculate_stars_max(user, event)
    Timeslot.where(
      user_id: user.is_a?(User) ? user.id : user,
      event_id: event.id).count * 3
  end

  def enroll(event, owner, user)
    if user.nil?
      return false
    end

    self.user = user

    if self.save
      EventMailer.enrollment_email(event, owner, user).deliver
      return true
    else
      return false
    end
  end
end
