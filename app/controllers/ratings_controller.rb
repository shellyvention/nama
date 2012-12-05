class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
  end

  def show_event_rating
    @event = Event.find(params[:event_id])
    @users = User.event_participants(@event)
  end

  def update_event_rating
    @event = Event.find(params[:event_id])
    event_id = params[:event_id]
    ratings = params[:rating]

    if ratings != nil
      ratings.keys.each do |id|
        # For debugging use only
        puts "user_id: " + id + ", params: " + ratings[id].inspect
        Rating.create(
          user_id: id, event_id: event_id, stars: ratings[id][:stars],
          stars_max: ratings[id][:stars_max], stars_extra: ratings[id][:stars_extra]
        )
      end
    end
    redirect_to @event
  end
end
