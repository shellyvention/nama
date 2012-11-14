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
end
