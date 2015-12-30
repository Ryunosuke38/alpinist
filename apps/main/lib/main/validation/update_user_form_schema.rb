require "dry-validation"
require "dry/validation/schema/form"

module Main
  module Validation
    class UpdateUserFormSchema < Dry::Validation::Schema::Form
      configure { config.messages = :i18n }

      key(:name) { |name| name.filled? }
      key(:email) { |email| email.filled? }

      optional(:password) { |password| password.none? | password.filled? }
      optional(:password_confirmation) { |confirmation| confirmation.none? | confirmation.filled? }

      rule(:password_confirmation, eql?: [:password, :password_confirmation])
    end
  end
end
