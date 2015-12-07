require "main/import"
require "main/view"

module Main
  module Views
    module Users
      class Index < Main::View
        include Main::Import("main.persistence.repositories.users")

        configure do |config|
          config.template = "users/index"
        end

        def locals(options = {})
          options = {per_page: 40, page: 1}.merge(options)

          {users: users.index(page: options[:page], per_page: options[:per_page])}
        end
      end
    end
  end
end
