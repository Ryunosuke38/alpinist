require "kleisli"
require "main/entities/user"
require "main/import"
require "transproc"

module Main
  module Operations
    class UpdateUser
      include Main::Import(
        "main.authentication.encrypt_password",
        "main.validation.update_user_form_schema",
        "persistence.update_user"
      )

      extend Transproc::Registry
      import Transproc::HashTransformations

      def call(user_id, params = {})
        validation = update_user_form_schema.(params)

        # TODO: work out if it's a dry-v bug requiring us to to_a here (atm, messages is `nil` when valid params are passed)
        if validation.messages.to_a.any?
          Left(validation.messages)
        else
          result = update_user.by_id(user_id).(prepare_attributes(validation.params))
          Right(Entities::User.new(result))
        end
      end

      private

      def prepare_attributes(params)
        attrs = transformer.(params)
        if params[:password].to_s != ""
          attrs.merge(encrypted_password: encrypt_password.(params[:password]))
        else
          attrs
        end
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
