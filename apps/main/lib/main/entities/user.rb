require "dry-data"
require "dry-equalizer"

module Main
  module Entities
    class User < Dry::Data::Struct
      include Dry::Equalizer.new(:id, :name, :email, :encrypted_password)

      attribute :id, "int"
      attribute :name, "string"
      attribute :email, "string"
      attribute :encrypted_password, "string"
    end
  end
end
