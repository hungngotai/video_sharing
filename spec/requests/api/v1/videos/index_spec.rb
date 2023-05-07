# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/videos' do
  let(:authorization) { '' }
  let(:headers) do
    {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }
  end
  let(:authorized_headers) do
    {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: authorization
    }
  end
  let(:email) { 'test@email.com' }
  let(:password) { 'password' }
  let(:user) do
    { email:, password: }
  end
  let(:params) do
    { user: }
  end

  context 'when user did not sign in' do
    before { get '/api/v1/videos', params: {}, headers: }

    it 'returns http unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns body with user info' do
      expect(response.parsed_body).to eq({ error: 'You need to sign in or sign up before continuing.' }.as_json)
    end
  end

  context 'when user signed in' do
    let(:authorization) do
      User.create(user)
      post('/users/sign_in', params: params.to_json, headers:)
      response.headers['Authorization']
    end

    before { get '/api/v1/videos', params: {}, headers: authorized_headers }

    it 'returns http ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns body with data' do
      expect(response.parsed_body).to eq({ data: [] }.as_json)
    end
  end
end
