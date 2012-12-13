class TimeslotsController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    redirect_to events_url(@event)
  end

  def create
    @event = Event.find(params[:event_id])
    timeslot = Timeslot.new(params[:timeslot])
    @event.timeslots << timeslot

    render 'refresh'
  end

  def destroy
    timeslot = Timeslot.find(params[:id])
    @event = timeslot.event
    @event.timeslots.delete timeslot

    render 'refresh'
  end

  def duplicate
    timeslot = Timeslot.find(params[:id])
    @event = timeslot.event
	timeslot = timeslot.dup
    @event.timeslots << timeslot

	render 'refresh'
  end

  def enroll
    timeslot = Timeslot.find(params[:id])
    @event = timeslot.event
    event_owner = timeslot.event.user

    if timeslot && timeslot.enroll(@event, event_owner, User.current)
	    render 'refresh'
    else
      flash[:error] = "Ups! Something went wrong. Please try again later!"
      redirect_to events_url
    end
  end
end
