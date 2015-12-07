require "dry-validation"
require "dry/validation/schema/form"

module Main
  module Validation
    class UserFormSchema < Dry::Validation::Schema::Form
      key(:name) { |name| name.filled? }
      key(:email) { |email| email.filled? }
      confirmation(:password)
    end
  end
end
