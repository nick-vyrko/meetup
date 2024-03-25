# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event tickets booking', type: :request do
  let(:user) { create(:user) }

  before do
    post '/sign-in', params: { user: { email: user.email, password: user.password } }
  end

  describe 'POST /events/:event_id/bookings' do
    let(:event) { create(:event, :with_tickets, total_tickets: 3) }

    before { event }

    it 'books tickets for the event' do
      post "/events/#{event.id}/bookings", params: { tickets_count: 2 }

      expect(response).to redirect_to(event_path(event))
      expect(flash[:notice]).to eq('Successfully booked 2 ticket(s)')

      expect(Ticket.where(event: event, user: user).count).to eq(2)
    end

    context 'when available tickets number less then requested' do
      it 'does not book any tickets' do
        post "/events/#{event.id}/bookings", params: { tickets_count: 4 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Sorry, we were not able to book the requested number of tickets')

        expect(Ticket.where(event: event, user: user).count).to eq(0)
      end
    end
  end
end
