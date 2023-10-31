require "digest/sha1"
require "jwt"

class User < ActiveRecord::Base
  logger = Rails.logger
  secret_key = ""
  algorithm = "HS256"

  class << self
    def hash_password(clear_password)
      Digest::SHA1.hexdigest(clear_password || "")
    end

    def generate_salt
      UtilsHelper.random_hex(16)
    end
  end

  def self.try_to_login(login, password)
    login = login.to_s.strip
    password = password.to_s

    return nil if login.empty? || password.empty?

    user = self.find_by_login(login)
    if user
      return nil unless user.check_password?(password)
    else
      logger.error("Can not login: " + login)
    end
    user
  rescue => text
    raise text
  end

  def self.token(login, password)
    user = User.try_to_login(login, password)
    if user
      jwt = Auth.encode({user: user.id})
    else
    end
  end

  def self.find_by_login(login)
    if login.present?
      user = where(:login => login).detect {|u| u.login == login}
      unless user
        user = find_by("LOWER(login) = ?", login.downcase)
      end
      user
    end
  end

  def check_password?(clear_password)
    User.hash_password(clear_password) == hashed_password
  end
end
