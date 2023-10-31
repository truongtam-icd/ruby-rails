class UtilsHelperTest < ActiveSupport::TestCase
  include UtilsHelper
  logger = Rails.logger

  test "random_hex" do
    random_hex =  UtilsHelper::random_hex(10)
    logger.info "random_hex: " + random_hex
    assert_equal(random_hex.length, 20)
  end
end