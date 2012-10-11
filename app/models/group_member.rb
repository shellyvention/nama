# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  group_id   :integer          default(0), not null
#  user_id    :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupMember < ActiveRecord::Base
	unloadable

	belongs_to :user
	belongs_to :group
end
