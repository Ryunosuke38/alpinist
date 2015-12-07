require "main/import"

module Main
  module Sessions
    class SignIn
      include Main::Import("main.sessions.authenticate")

      def call(input, session)
        user = authenticate.(input)
        session[:user_id] = user.id if user
        user
      end
    end
  end
end
