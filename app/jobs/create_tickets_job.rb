# frozen_string_literal: true

class CreateTicketsJob
  include Sidekiq::Job

  def perform(event_id, tickets_amount)
    data = tickets_amount.times.map do
      { event_id: event_id }
    end

    Ticket.insert_all(data)
  end
end
