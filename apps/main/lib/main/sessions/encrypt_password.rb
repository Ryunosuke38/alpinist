require "bcrypt"

module Main
  module Sessions
    class EncryptPassword
      include BCrypt

      def call(input)
        Password.create(input)
      end

      def same?(hash, password)
        Password.new(hash) == password
      end
    end
  end
end
