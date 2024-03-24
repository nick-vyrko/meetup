# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Rails.cache.fetch("upcoming_events", expires_in: 5.minutes) do
      Event.upcoming.to_a
    end
  end

  def show
    @event = Event.find(params[:id])
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

  def event_params
    params.require(:event).permit(:name, :description, :datetime, :latitude, :longitude, :total_tickets)
  end
end
