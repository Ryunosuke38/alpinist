require "rom"
require "rom-repository"

Alpinist::Container.namespace "persistence" do |container|
  config = ROM::Configuration.new(:sql, Alpinist::Container.options.database_url)

  container.register('config', config)

  container.require('core/container/persistence')

  container.finalize(:rom) do
    config.auto_registration(container.root.join('lib/persistence'))
    container.register('rom', ROM.container(config))
  end
end
