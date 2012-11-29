class EventsController < ApplicationController
  before_filter :authorize_organizer, except: [:index, :show]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      flash[:success] = "Event was successfully created."
	  redirect_to @event
	else
	  render 'new'
	end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:success] = "Event was successfully updated."
	  redirect_to @event
	else
	  render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy
	flash[:success] = "Event was successfully deleted."
    redirect_to events_url
  end
end
