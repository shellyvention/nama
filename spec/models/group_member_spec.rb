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

require 'spec_helper'

describe GroupMember do

  let(:user) { FactoryGirl.create(:user) }
  let(:group) { FactoryGirl.create(:group) }

  before do
    @member = GroupMember.new()
    @member.group = group
    @member.user = user
  end

  subject { @member }
end
