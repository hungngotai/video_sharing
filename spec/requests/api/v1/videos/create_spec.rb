require 'rails_helper'

RSpec.describe 'POST /api/v1/videos', type: :request do
  let(:authorization) { '' }
  let(:headers) {
    {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  }
  let(:authorized_headers) {
    {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authorization
    }
  }
  let(:src) { 'https://www.youtube.com/embed/uCHuTxVYtsk' }
  let(:description) { 'description' }
  let(:video) {
    { src: src, description: description }
  }
  let(:params) {
    { video: video }
  }
  let(:email) { 'test@email.com' }
  let(:password) { 'password' }
  let(:user) {
    { email: email, password: password }
  }
  let(:user_params) {
    { user: user }
  }

  context 'when request is unauthorized' do
    before { post '/api/v1/videos', params: params.to_json, headers: headers }

    it 'returns http unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns body with error message' do
      expect(response.parsed_body).to eq({ error: 'You need to sign in or sign up before continuing.' }.as_json)
    end
  end

  context 'when request is authorized' do
    let!(:create_user) { User.create(user) }

    let(:authorization) {
      post '/users/sign_in', params: user_params.to_json, headers: headers
      response.headers['Authorization']
    }

    before { post '/api/v1/videos', params: params.to_json, headers: authorized_headers }

    context 'when params is valid' do
      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns body with data' do
        body = response.parsed_body
        result = { message: body['message'], video: { src: body['video']['src'], description: body['video']['description'] }}
        expect(result).to eq({ message: 'Create', video: { src: src, description: description } })
      end
    end

    context 'when params is invalid' do
      let(:src) { '' }

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns body with error' do
        video = Video.new()
        video.validate
        expect(response.parsed_body).to eq({ error: video.errors.full_messages }.as_json)
      end
    end
  end
end
