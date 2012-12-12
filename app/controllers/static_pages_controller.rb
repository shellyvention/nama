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
    @num_members = User.where("email != \'nama\'").count
    @num_groups = Group.count
    @num_males = User.where("gender == 0").count
    @num_females = User.where("gender == 1").count
    @num_upcoming_events = Event.upcoming.count
    @num_past_events = Event.past.count
  end

  def home_user
  end
end
