class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
    @users = User.all
  end

  def show_event_rating
    @event = Event.find(params[:event_id])
    @users = User.event_participants(@event)

    event_ratings = Rating.event_ratings(@event)
    @stars = event_ratings.sum(:stars, :group => :user_id)
    @stars_max = event_ratings.sum(:stars_max, :group => :user_id)
    @stars_extra = event_ratings.sum(:stars_extra, :group => :user_id)
  end

  def update_event_rating
    @event = Event.find(params[:event_id])
    event_id = params[:event_id]
    ratings = params[:rating]

    if ratings != nil
      ratings.keys.each do |id|
        Rating.create(
          user_id: id, event_id: event_id, stars: ratings[id][:stars],
          stars_max: ratings[id][:stars_max], stars_extra: ratings[id][:stars_extra]
        )
      end
    end
    redirect_to @event
  end
end
