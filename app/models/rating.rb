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
end
