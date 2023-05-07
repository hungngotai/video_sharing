# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users', type: :request do
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

  context 'When email exists' do
    before do
      User.create(user)
      post '/users', params: params.to_json, headers:
    end

    it 'returns http unprosessable entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns body with error message' do
      expect(response.parsed_body).to eq({ 'error' => 'Something went wrong.' })
    end
  end

  context 'When email does not exist' do
    let(:email) { 'new_test@email.com' }

    before { post '/users', params: params.to_json, headers: }

    it 'returns http ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns body with user info' do
      body = response.parsed_body
      expect({ message: body['message'], user_email: body['user']['email'] }).to eq({
                                                                                      message: 'Signed up successfully',
                                                                                      user_email: email
                                                                                    })
    end
  end

  context 'When email is invalidate' do
    let(:email) { 'test_email.com' }

    before { post '/users', params: params.to_json, headers: }

    it 'returns http unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns body with error message' do
      expect(response.parsed_body).to eq({ 'error' => 'Something went wrong.' })
    end
  end

  context 'When password is invalidate' do
    let(:password) { '1' }

    before { post '/users', params: params.to_json, headers: }

    it 'returns http unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns body with error message' do
      expect(response.parsed_body).to eq({ 'error' => 'Something went wrong.' })
    end
  end
end
