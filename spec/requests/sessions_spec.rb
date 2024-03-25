# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions management', type: :request do
  describe 'GET /' do
    it 'renders view' do
      get '/'
      expect(response.body).to include('Welcome to', 'Meetup!', 'Sign In')
    end
  end

  describe 'POST sign-in/' do
    let(:params) { { user: { email: email, password: password } } }
    let(:email) { "testmail@mail.com" }
    let(:password) { '123123' }
    let(:user) { create(:user, email: email, password: password) }

    before { user }

    it 'creates a session' do
      post '/sign-in', params: params

      expect(response).to redirect_to(events_path)
    end

    context 'when credentials are incorrect' do
      let(:user) { create(:user) }

      it 'renders login page' do
        post '/sign-in', params: params

        expect(response.body).to include('Email or password is not correct')
      end
    end
  end

  describe 'DELETE sign-out/' do
    let(:params) { { user: { email: user.email, password: user.password } } }
    let(:user) { create(:user) }

    before do
      post '/sign-in', params: params
    end

    it 'redirects to login page' do
      delete '/sign-out'

      expect(response).to redirect_to('/')
    end
  end
end
