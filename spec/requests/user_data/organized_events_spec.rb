# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User's organized events", type: :request do
  let(:user) { create(:user) }

  before do
    post '/sign-in', params: { user: { email: user.email, password: user.password } }
  end

  describe 'GET /user/organized_events' do
    let(:event1) { create(:event, user: user) }
    let(:event2) { create(:event) }

    before do
      event1
      event2
    end

    it 'shows list of events created by user' do ||
      get '/user/organized_events'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(event1.name)
      expect(response.body).not_to include(event2.name)
    end
  end

end
