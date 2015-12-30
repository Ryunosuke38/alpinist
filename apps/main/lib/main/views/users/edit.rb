require "main/import"
require "main/view"

module Main
  module Views
    module Users
      class Edit < Main::View
        include Main::Import("main.persistence.repositories.users")

        configure do |config|
          config.template = "users/edit"
        end

        def locals(options = {})
          user = users[options.fetch(:id)]

          {
            user: user,
            params: options.fetch(:params) { form_params(user) },
            errors: options[:errors],
          }
        end

        private

        def form_params(user)
          %w(name email).map { |attr| [attr, user.send(attr)] }.to_h
        end
      end
    end
  end
end
