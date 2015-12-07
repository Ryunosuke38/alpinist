require "kleisli"
require "main/entities/user"
require "main/import"
require "transproc"

module Main
  module Operations
    class UpdateUser
      include Main::Import(
        "main.sessions.encrypt_password",
        "main.validation.user_form_schema",
        "persistence.update_user"
      )

      extend Transproc::Registry
      import Transproc::HashTransformations

      def call(user_id, params = {})
        validation = user_form_schema.(params)

        if validation.messages.any?
          Left(validation.messages)
        else
          result = update_user.by_id(user_id).(prepare_attributes(validation.params))
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
