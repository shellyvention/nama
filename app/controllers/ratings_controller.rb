class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
    @users = User.all
  end

  def show_event_rating
    @event = Event.find(params[:event_id])
    @users = User.event_participants(@event)

    @ratings = {}
    @users.each do |user|
      rating = Rating.user_event_rating(user, @event).first
      if rating.nil?
        rating = Rating.new
        rating.stars_max = Timeslot.calculate_stars_max(user, @event)
      end
      @ratings[user.id] = rating
    end
  end

  def update_event_rating
    @event = Event.find(params[:event_id])
    event_id = params[:event_id]
    ratings = params[:rating]

    if ratings != nil
      ratings.keys.each do |id|
        rating = Rating.user_event_rating(id, @event).first
        if rating
          rating.update_attributes(stars: ratings[id][:stars],
            stars_extra: ratings[id][:stars_extra])
        else
          stars_max = Timeslot.calculate_stars_max(id, @event)
          Rating.create(
            user_id: id, event_id: event_id, stars: ratings[id][:stars],
            stars_max: stars_max, stars_extra: ratings[id][:stars_extra]
          )
        end
      end
    end
    redirect_to @event
  end
end
