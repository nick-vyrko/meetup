# frozen_string_literal: true

class BookEventTickets
  def initialize(user:, event:, tickets_count:)
    @user = user
    @event = event
    @tickets_count = tickets_count
  end

  def call
    ActiveRecord::Base.transaction do
      available_tickets = Ticket.where(event_id: event.id, user_id: nil).limit(tickets_count).lock.load

      return 0 if available_tickets.size < tickets_count

      Ticket.where(id: available_tickets.pluck(:id)).update_all(user_id: user.id, updated_at: Time.current)
    end
  end

  private

  attr_reader :user, :event, :tickets_count
end
