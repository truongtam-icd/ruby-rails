require "jwt"

class Auth
  ALGORITHM = "HS256"

  def self.encode(payload)
    JWT.encode payload, auth_secret, ALGORITHM
  end

  def self.decode(token)
    begin
      JWT.decode token, auth_secret, true, { algorithm: ALGORITHM }
    rescue JWT::ExpiredSignature
      logger = Rails.logger
      logger.info("ExpiredSignature")
      return nil
    rescue JWT::DecodeError
      logger = Rails.logger
      logger.info("DecodeError")
      return nil
    end
  end

  def self.auth_secret
    ENV["AUTH_SECRET"] = "my$ecretK3y"
  end
end