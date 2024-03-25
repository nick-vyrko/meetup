# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    user
    sequence(:name) { |n| "event_#{n}" }
    description { 'description text' }
    datetime { Time.current.tomorrow }
    latitude { 1 }
    longitude { 1 }
    total_tickets { 10 }

    trait :with_tickets do
      after(:create) do |event|
        tickets_data = event.total_tickets.times.map { { event_id: event.id } }
        Ticket.insert_all(tickets_data)
      end
    end

    trait :past do
      datetime { Time.current.yesterday }
    end
  end
end
