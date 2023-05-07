# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JwtHelper
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      token = Base64.decode64(request.params['token']).split[1]
      if (verified_user = decode_user(token))
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
