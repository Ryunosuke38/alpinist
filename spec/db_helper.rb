require_relative "spec_helper"

Alpinist::Container.boot! :i18n
Alpinist::Container.boot! :rom

Dir[SPEC_ROOT.join("support/db/*.rb").to_s].each(&method(:require))
Dir[SPEC_ROOT.join("shared/db/*.rb").to_s].each(&method(:require))

require "database_cleaner"
DatabaseCleaner[:sequel, connection: TestHelpers.db_connection].strategy = :transaction

RSpec.configure do |config|
  config.include TestHelpers
  config.include TestFactories

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
