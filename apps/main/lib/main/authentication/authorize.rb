require "main/import"

module Main
  module Authentication
    class Authorize
      include Main::Import("main.persistence.repositories.users")

      def call(session, &block)
        user_id = session[:user_id]

        if user_id
          yield users[user_id]
        else
          yield nil
        end
      end
    end
  end
end
