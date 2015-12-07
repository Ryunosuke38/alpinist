module Api
  module Views
    class Home < Api::View
      configure do |config|
        config.template = "home"
      end
    end
  end
end
