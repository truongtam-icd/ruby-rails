module UtilsHelper

  class << self
    def random_hex(n)
      SecureRandom.hex(n)
    end
  end
end