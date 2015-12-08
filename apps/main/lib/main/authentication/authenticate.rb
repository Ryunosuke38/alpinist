require "main/import"

module Main
  module Authentication
    class Authenticate
      include Main::Import("main.authentication.encrypt_password", "main.persistence.repositories.users")

      def call(attributes)
        email, password = attributes.values_at("email", "password")
        user = users.by_email(email)

        if user && encrypt_password.same?(user.encrypted_password, password)
          user
        end
      end
    end
  end
end
