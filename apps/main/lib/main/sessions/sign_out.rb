require "main/import"

module Main
  module Sessions
    class SignOut
      def call(session)
        session[:user_id] = nil
      end
    end
  end
end
