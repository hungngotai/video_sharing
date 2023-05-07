# frozen_string_literal: true

module JwtHelper
  def decode_user(token)
    Warden::JWTAuth::UserDecoder.new.call token, :user, nil if token
  rescue JWT::DecodeError
    nil
  end

  def encode_user(user)
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end
end
