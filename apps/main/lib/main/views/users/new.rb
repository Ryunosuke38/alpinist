require "main/view"

module Main
  module Views
    module Users
      class New < Main::View
        configure do |config|
          config.template = "users/new"
        end

        def locals(options = {})
          {
            params: options[:params],
            errors: options[:errors]
          }
        end
      end
    end
  end
end
