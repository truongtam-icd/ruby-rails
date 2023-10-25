class UtilsHelperTest < ActiveSupport::TestCase
  include TokenHelper

  logger = Rails.logger

  test "token" do
    token =  TokenHelper::generate_token_value()
    logger.info 'token: ' + token
    assert_equal(token.length, 40)
  end
end