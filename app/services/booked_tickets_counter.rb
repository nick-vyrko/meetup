# frozen_string_literal: true

class BookedTicketsCounter
  LIST_VALUE_PLACEHOLDER = 1

  def initialize(event)
    @event = event
    @redis_key = "#{event.id}/booked_tickets"
  end

  def increase_counter(value)
    RedisCurrent.connection.rpush(redis_key, Array.new(value, LIST_VALUE_PLACEHOLDER))
  end

  def count
    RedisCurrent.connection.llen(redis_key)
  end

  private

  attr_reader :event, :redis_key
end
