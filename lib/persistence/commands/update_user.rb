require "dry-data"

module Persistence
  module Commands
    class UpdateUser < ROM::Commands::Update[:sql]
      input Dry::Data["hash"].schema(
        name: "string",
        email: "string",
        encrypted_password: "string",
      )

      relation :users
      register_as :update
      result :one
    end
  end
end
