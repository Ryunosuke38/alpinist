require_relative "container"

module Alpinist
  Import = Alpinist::Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end
