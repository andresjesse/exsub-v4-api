require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern

  #JWT_SECRET = Rails.application.jwt_secret
  JWT_SECRET = 'SECRET' #TODO: migrate to env

  def jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, JWT_SECRET).first
    HashWithIndifferentAccess.new decoded
  end
end