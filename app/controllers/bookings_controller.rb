# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    @booked_tickets_count = BookEventTickets.new(user: current_user, event: event, tickets_count: tickets_count).call

    if @booked_tickets_count.zero?
      render partial: 'events/show/booking_result', status: :unprocessable_entity
    else
      redirect_to event_path(event.id), flash: { notice: "Successfully booked #{@booked_tickets_count} ticket(s)" }
    end
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def tickets_count
    params[:tickets_count].to_i
  end
end
