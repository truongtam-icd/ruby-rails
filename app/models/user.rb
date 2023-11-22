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
      return jwt
    else
    end
    return nil
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

  def self.info_user(id)
    user = where(:id => id).detect {|u| u.id == id}
    if (user)
      return {
        firstname: user["firstname"],
        lastname: user["lastname"],
        mail: user["mail"],
        id: user["id"]
      }
    else
      return nil
    end
  end

  def self.update_user(id, payload)
    user = where(:id => id).detect {|u| u.id == id}
    if (user)
      User.where(['id = ?', id]).update_all([
        'firstname = ?, lastname = ?',
        payload[:firstname],
        payload[:lastname]
      ])
      return true
    else
      return nil
    end
  end

  def self.insert_user(payload)
    if !payload[:login]
      return nil
    end

    user = self.find_by_login(payload[:login])
    if (user)
      return nil
    else
      user = User.new :firstname => payload[:firstname],
                      :lastname => payload[:lastname],
                      :mail => payload[:email],
                      :mail_notification => true,
                      :status => 1
      user.login = payload[:login]
      user.hashed_password = User.hash_password(payload[:password])
      user.admin = false
      user.save
      return true
    end
  end

  def check_password?(clear_password)
    User.hash_password(clear_password) == hashed_password
  end
end
