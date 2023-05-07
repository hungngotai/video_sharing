# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    before_action :authenticate_user!

    private

    def get_user_from_token
      jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                               Rails.application.credentials.devise[:jwt_secret_token]).first
      user_id = jwt_payload['sub']
      User.find(user_id.to_s)
    end
  end
end
