# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Group do

	before do
		@group = Group.new(name: "Group 1")
	end

	subject { @group }

	it { should respond_to(:name) }

	it { should be_valid }

	describe "when name is not present" do
		before { @group.name = " " }
		it { should_not be_valid }
	end
end
