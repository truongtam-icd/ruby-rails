require "test_helper"

class UserTest < ActiveSupport::TestCase
  logger = Rails.logger

  test "user_login" do
    userCreate = User.new :firstname => "Test",
         :lastname => "Admin",
         :mail => "admin@example.net",
         :mail_notification => true,
         :status => 1
    userCreate.login = 'admin'
    userCreate.hashed_password = "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    userCreate.admin = true
    userCreate.save

    user = User.try_to_login("admin", "test")
    assert_equal(user.login, "admin")
  end

  test "hash_password" do
    hash_password = User.hash_password("test")
    logger.info("hash_password: " + hash_password)
  end

  test "token" do
    token = User.token("admin", "test")
    logger.info(token)
  end
end
