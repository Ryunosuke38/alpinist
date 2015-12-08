require "i18n"

I18n.load_path += Dir["#{Alpinist::Container.root}/apps/*/locales/**/*.yml"]

I18n.backend.load_translations
