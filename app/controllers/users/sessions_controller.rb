# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    protect_from_forgery with: :null_session
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      render json: {
        message: 'You are logged in.',
        user: current_user
      }, status: :ok
    end

    def respond_to_on_destroy
      log_out_success and return if current_user

      log_out_failure
    end

    def log_out_success
      render json: { message: 'You are logged out.' }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end
end
