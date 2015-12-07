require "main/view"

module Main
  module Views
    class SignIn < Main::View
      configure do |config|
        config.template = "sign_in"
      end
    end
  end
end
