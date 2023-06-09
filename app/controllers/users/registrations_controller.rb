# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protect_from_forgery with: :null_session
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      register_success and return if resource.persisted?

      register_failed
    end

    def register_success
      render json: {
        message: 'Signed up successfully',
        user: current_user
      }, status: :ok
    end

    def register_failed
      render json: { error: 'Something went wrong.' }, status: :unprocessable_entity
    end
  end
end
