class StaticPagesController < ApplicationController
  def signup
  end

  def help
  end

  def about
  end

  def contact
  end

  def home_admin
    @num_members = User.num_members.count
    @num_groups = Group.count
    @num_males = User.num_males.count
    @num_females = User.num_females.count
    @num_upcoming_events = Event.upcoming.count
    @num_past_events = Event.past.count
  end

  def home_user
  end
end
