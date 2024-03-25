# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateTicketsJob do
  subject { described_class.new.perform(event_id, tickets_amount) }

  let(:event_id) { 1 }
  let(:tickets_amount) { 3 }

  it 'creates multiple tickets in a single query' do
    expect(Ticket).to receive(:insert_all).with([{ event_id: event_id }, { event_id: event_id },
                                                 { event_id: event_id }])

    subject
  end
end
