# frozen_string_literal: true

class IncreaseBookedTicketsCounterJob
  include Sidekiq::Job

  def perform(event_id, value)
    event = Event.find(event_id)

    BookedTicketsCounter.new(event).increase_counter(value)
  end
end
