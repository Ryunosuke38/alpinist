require "rodakase/container"

module Alpinist
  class Container < Rodakase::Container
    configure do
      load_paths! "lib", "core"
    end
  end
end
