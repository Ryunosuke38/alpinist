require "i18n"

# Load dry-validation's i18n support first, so we can override if we want
require "dry/validation/messages/i18n"

I18n.load_path += Dir["#{Alpinist::Container.root}/apps/*/locales/**/*.yml"]

I18n.backend.load_translations
