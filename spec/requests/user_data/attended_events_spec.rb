# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User's attended events", type: :request do
  let(:user) { create(:user) }
  let(:event1) { create(:event, :with_tickets, total_tickets: 2) }

  let(:booked_ticket) { create(:ticket, event: event1, user: user) }

  before do
    booked_ticket

    post '/sign-in', params: { user: { email: user.email, password: user.password } }
  end

  describe 'GET /user/attended_events' do
    let(:event2) { create(:event, :with_tickets, total_tickets: 2) }

    before { event2 }

    it 'displays events for which the user has booked tickets' do
      get '/user/attended_events'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(event1.name)
      expect(response.body).not_to include(event2.name)
    end
  end

  describe 'GET /user/attended_events/:id' do
    it "shows event's booked tickets" do
      get "/user/attended_events/#{event1.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Ticket number:\n#{booked_ticket.id}")
    end
  end
end
