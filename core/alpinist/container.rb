require "rodakase/container"

module Alpinist
  class Container < Rodakase::Container
    configure do |config|
      config.name = :core
    end

    load_paths! "lib", "core"
  end
end
