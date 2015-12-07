require_relative "api/container"

Api::Container.finalize! do |container|
  container.auto_register! "lib/main/persistence/repositories" do |repo_class|
    -> { repo_class.new(container["persistence.rom"]) }
  end
end

require "api/application"
require "api/view"
require "api/transactions"

Api::Container.require "transactions/**/*.rb"
