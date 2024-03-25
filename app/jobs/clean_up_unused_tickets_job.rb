# frozen_string_literal: true

class CleanUpUnusedTicketsJob
  include Sidekiq::Job

  def perform
    unused_tickets_of_past_events.in_batches do |tickets|
      tickets.destroy_all
    end
  end

  private

  def unused_tickets_of_past_events
    Ticket.joins(:event)
          .where(tickets: { user_id: nil })
          .where('events.datetime < ?', Time.current)
          .select('tickets.id')
  end
end
