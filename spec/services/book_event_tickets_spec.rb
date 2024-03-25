# frozen_string_literal: true

require 'sidekiq/testing'
require 'rails_helper'

RSpec.describe BookEventTickets do
  subject { described_class.new(user: user, event: event, tickets_count: tickets_count).call }

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:tickets_count) { 2 }

  before do
    Sidekiq::Testing.fake!
  end

  context 'when there are enough tickets available' do
    let(:available_tickets) { create_list(:ticket, 2, event: event) }

    before { available_tickets }

    it 'books tickets with the provided user' do
      subject

      expect(available_tickets.first.reload.user_id).to eq(user.id)
      expect(available_tickets.second.reload.user_id).to eq(user.id)
    end

    it 'schedules IncreaseBookedTicketsCounterJob' do
      expect { subject }.to change(IncreaseBookedTicketsCounterJob.jobs, :size).by(1)
    end
  end

  context 'when there are not enough tickets available' do
    let(:ticket) { create(:ticket, event: event) }

    before { ticket }

    it 'does not book tickets' do
      subject

      expect(ticket.reload.user_id).to be(nil)
    end

    it 'does not schedule IncreaseBookedTicketsCounterJob' do
      expect { subject }.not_to change(IncreaseBookedTicketsCounterJob.jobs, :size)
    end
  end
end
