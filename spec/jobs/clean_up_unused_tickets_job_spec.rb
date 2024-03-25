# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CleanUpUnusedTicketsJob do
  subject { described_class.new.perform }

  let(:event) { create(:event, :past, :with_tickets, total_tickets: 3) }
  let(:user) { create(:user) }
  let(:used_ticket) { create(:ticket, event: event, user: user) }

  before do
    used_ticket
  end

  it 'deletes all the unused tickets' do
    freeze_time do
      expect { subject }.to change(Ticket, :count).by(-3)

      expect(used_ticket.reload.persisted?).to be(true)
    end
  end
end
