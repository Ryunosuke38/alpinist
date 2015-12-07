require_relative "container"

module Api
  Import = Api::Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end
