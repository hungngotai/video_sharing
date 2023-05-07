# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotUnique, with: :unprocessable_entity_handler

  def unprocessable_entity_handler(_error)
    render json: { error: 'Something went wrong.' }, status: :unprocessable_entity
  end
end
