require 'rails_helper'

RSpec.describe "GET /api/v1/videos", type: :request do
  let(:authorization) { "" }
  let(:headers) {
    {
      "Accept": "application/json",
      "Content-Type": "application/json"
    }
  }
  let(:authorized_headers) {
    {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": authorization
    }
  }
  let(:email) { "test@email.com" }
  let(:password) { "password" }
  let(:user) {
    { email: email, password: password }
  }
  let(:params) {
    { user: user }
  }

  context "when user did not sign in" do
    before { get "/api/v1/videos", params: {}, headers: headers }

    it "returns http unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns body with user info" do
      expect(response.parsed_body).to eq({ error: "You need to sign in or sign up before continuing." }.as_json)
    end
  end

  context "when user signed in" do
    let(:authorization) {
      User.create(user)
      post "/users/sign_in", params: params.to_json, headers: headers
      response.headers["Authorization"]
    }

    before { get "/api/v1/videos", params: {}, headers: authorized_headers }

    it "returns http ok" do
      expect(response).to have_http_status(:ok)
    end

    it "returns body with data" do
      expect(response.parsed_body).to eq({ data: [] }.as_json)
    end
  end
end
