# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users management', type: :request do
  describe 'GET /sign-up' do
    it 'show registration page' do
      get '/sign-up'

      expect(response.body).to include('Name', 'Create an account')
    end
  end

  describe 'POST /sign-up' do
    let(:params) { { user: { name: 'Agent', email: 'agent.smith@mail.ru', password: '123123' } } }

    it 'creates user' do
      post '/sign-up', params: params

      expect(response).to redirect_to(events_path)
      expect(User.first).to have_attributes(name: 'Agent', email: 'agent.smith@mail.ru')
    end

    context 'with invalid params' do
      let(:params) { { user: { name: 'Agent', email: 'agent.smith@mail.ru', password: '1' } } }

      it 'renders registration page' do
        post '/sign-up', params: params

        expect(response.body).to include('Name', 'Create an account')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
