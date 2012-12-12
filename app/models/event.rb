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

class Event < ActiveRecord::Base
  attr_accessible :date, :description, :name, :user_id

  belongs_to :user
  has_many :timeslots, dependent: :destroy
  has_many :ratings

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :user_id, presence: true
  validates :date, presence: true

  default_scope { order(:date) }
  scope :upcoming, lambda {
    where(
      "\"date\" >= ?", Date.today)
  }

  scope :past, lambda {
    where(
      "\"date\" < ?", Date.today)
  }
end
