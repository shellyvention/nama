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

require 'spec_helper'

describe Rating do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @rating = Rating.new(
      stars: 3,
      stars_max: 6,
      stars_extra: 0)

    @rating.user = user
    @rating.save
  end

  subject { @rating }

  describe "rating per user" do
    it "should return stars for user" do
      Rating.rating_per_user(user.id, "stars").should == 3
    end
  end

  describe "rating per user" do
    it "should return stars_max for user" do
      Rating.rating_per_user(user.id, "stars_max").should == 6
    end
  end

  describe "rating per user" do
    it "should return stars_extra for user" do
      Rating.rating_per_user(user.id, "stars_extra").should == 0
    end
  end
end
