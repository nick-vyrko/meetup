# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncreaseBookedTicketsCounterJob do
  subject { described_class.new.perform(event.id, value) }

  let(:event) { build_stubbed(:event) }
  let(:value) { 10 }
  let(:booked_tickets_counter) { instance_double('BookedTicketsCounter') }

  before do
    allow(BookedTicketsCounter).to receive(:new).and_return(booked_tickets_counter)
    allow(Event).to receive(:find).with(event.id).and_return(event)
  end

  it 'executes BookedTicketsCounter service' do
    expect(BookedTicketsCounter).to receive(:new).with(event)
    expect(booked_tickets_counter).to receive(:increase_counter).with(value)

    subject
  end
end
