# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Rails.cache.fetch('upcoming_events', expires_in: 5.minutes) do
      Event.upcoming.to_a
    end

    @tickets_left = @events.each_with_object({}) { |event, obj| obj[event.id] = tickets_left(event) }
  end

  def show
    @event = Event.find(params[:id])
    @tickets_left = tickets_left(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(user: current_user, **event_params.merge(latitude: 1, longitude: 1))

    if @event.save
      CreateTicketsJob.perform_async(@event.id, @event.total_tickets)
      redirect_to event_path(@event.id)
    else
      render :new
    end
  end

  private

  def tickets_left(event)
    event.total_tickets - BookedTicketsCounter.new(event).count
  end

  def event_params
    params.require(:event).permit(:name, :description, :datetime, :latitude, :longitude, :total_tickets)
  end
end
