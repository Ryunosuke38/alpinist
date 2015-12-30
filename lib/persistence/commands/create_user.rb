require "dry-data"

module Persistence
  module Commands
    class CreateUser < ROM::Commands::Create[:sql]
      input Dry::Data["hash"].schema(
        name: "string",
        email: "string",
        encrypted_password: "string",
      )

      relation :users
      register_as :create
      result :one
    end
  end
end
