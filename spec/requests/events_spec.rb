# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events managements', type: :request do
  let(:user) { create(:user) }

  before do
    post '/sign-in', params: { user: { email: user.email, password: user.password } }
  end

  describe 'GET /events' do
    let(:past_event) { create(:event, :past) }
    let(:upcoming_events) { create_list(:event, 2) }

    before do
      past_event
      upcoming_events
    end

    it 'displays list of upcoming events' do
      get '/events'

      expect(response.body).to include(*upcoming_events.map(&:name))
      expect(response.body).not_to include(past_event.name)
    end
  end

  describe 'POST /events' do
    let(:datetime) { '2024-03-25T18:23:51' }
    let(:params) { { event: { name: 'test event', description: '', datetime: datetime, total_tickets: 3 } } }

    it 'creates event' do
      post '/events', params: params

      expect(response).to redirect_to(event_path(Event.first))
      expect(Event.first).to have_attributes(user_id: user.id, name: 'test event', datetime: DateTime.parse(datetime), total_tickets: 3)
    end
  end

  describe 'GET /events/new' do
    it 'renders new event page' do
      get '/events/new'

      expect(response.body).to include('Name', 'Date', 'Description', 'Available Tickets', 'Create Event')
    end
  end

  describe 'GET /events/:id' do
    let(:event) { create(:event) }

    before { event }

    it 'shows event page' do
      get "/events/#{event.id}"

      expect(response.body).to include(event.name, event.description)
    end
  end
end
