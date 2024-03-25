# frozen_string_literal: true

class BookEventTickets
  def initialize(user:, event:, tickets_count:)
    @user = user
    @event = event
    @tickets_count = tickets_count
  end

  def call
    book_tickets.tap do |booked_tickets_number|
      update_counter(booked_tickets_number)
    end
  end

  private

  attr_reader :user, :event, :tickets_count

  def book_tickets
    ActiveRecord::Base.transaction do
      available_tickets = Ticket.where(event_id: event.id, user_id: nil).limit(tickets_count).lock.load

      return 0 if available_tickets.size < tickets_count

      Ticket.where(id: available_tickets.pluck(:id)).update_all(user_id: user.id, updated_at: Time.current)
    end
  end

  def update_counter(value)
    IncreaseBookedTicketsCounterJob.perform_async(event.id, value)
  end
end
