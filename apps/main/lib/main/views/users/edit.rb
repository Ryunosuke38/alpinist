require "main/import"
require "main/view"

module Main
  module Views
    module Users
      class Edit < Main::View
        include Main::Import("main.persistence.repositories.users")

        configure do |config|
          config.template = "users/new"
        end

        def locals(options = {})
          {
            user: options.fetch(:user) { user_attrs(options.fetch(:id)) },
            errors: options[:errors]
          }
        end

        private

        # TODO: Find a less laborious way to do this
        def user_attrs(id)
          user = users[id]

          %w(name email).map { |attr| [attr, user.send(attr)] }.to_h
        end
      end
    end
  end
end
