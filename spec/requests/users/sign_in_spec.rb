# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST users/sign_in', type: :request do
  let(:email) { 'test@email.com' }
  let(:password) { 'password' }
  let(:user) do
    { email:, password: }
  end
  let(:params) do
    { user: }
  end
  let(:headers) do
    {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  end

  context 'When credentials is invalid' do
    before { post '/users/sign_in', params: params.to_json, headers: }

    it 'returns http unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns body with error message' do
      expect(response.parsed_body).to eq({ 'error' => 'Invalid Email or password.' })
    end
  end

  context 'When credentials is valid' do
    let!(:current_user) { User.create(user) }

    before { post '/users/sign_in', params: params.to_json, headers: }

    it 'returns http ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns body with user info' do
      expect(response.parsed_body).to eq({
        message: 'You are logged in.',
        user: current_user
      }.as_json)
    end
  end
end
