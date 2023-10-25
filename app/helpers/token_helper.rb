module TokenHelper
  include UtilsHelper

  class << self
    def generate_token_value
      UtilsHelper.random_hex(20)
    end
  end
end