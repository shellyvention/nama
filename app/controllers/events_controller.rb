class EventsController < ApplicationController
  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])

    if @event.save
      flash[:success] = "Event was successfully created."
	  redirect_to @event
	else
	  render 'new'
	end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:success] = "Event was successfully updated."
	  redirect_to @event
	else
	  render 'edit'
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])

    @event.destroy
	flash[:success] = "Event was successfully deleted."
    redirect_to events_url
  end
end
