# == Schema Information
#
# Table name: ratings
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  event_id    :integer
#  stars       :integer
#  stars_max   :integer
#  stars_extra :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :user_id, :event_id, :stars, :stars_max, :stars_extra

  belongs_to :user
  belongs_to :event

  def rating_per_event
    Rating.joins(:event).where(
        "events.date = :date AND timeslots.user_id = :user_id AND :to >= \"from\" AND \"to\" >= :from",
        date: event.date, user_id: User.current.id, to: to, from: from)
  end
end
