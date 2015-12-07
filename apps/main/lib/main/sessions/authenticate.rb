require "main/import"

module Main
  module Sessions
    class Authenticate
      include Main::Import("main.sessions.encrypt_password", "main.persistence.repositories.users")

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
