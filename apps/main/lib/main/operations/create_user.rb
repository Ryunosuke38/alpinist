require "kleisli"
require "main/entities/user"
require "main/import"
require "transproc"

module Main
  module Operations
    class CreateUser
      include Main::Import("main.sessions.encrypt_password", "main.validation.user_form_schema", "persistence.create_user")

      extend Transproc::Registry
      import Transproc::HashTransformations

      def call(params = {})
        validation = user_form_schema.(params)

        if validation.messages.any?
          Left(validation.messages)
        else
          result = create_user.(prepare_attributes(validation.params))
          Right(Entities::User.new(result))
        end
      end

      private

      def prepare_attributes(params)
        attrs = transformer.(params)
        attrs.merge(encrypted_password: encrypt_password.(params[:password]))
      end

      def transformer
        self.class[:accept_keys, [
          :email,
          :name,
        ]]
      end
    end
  end
end
