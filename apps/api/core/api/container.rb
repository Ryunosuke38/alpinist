module Api
  class Container < Rodakase::Container
    require root.join('core/alpinist/container')
    import Alpinist::Container

    configure do |config|
      config.root = Pathname(__FILE__).join("../..").realpath.dirname.freeze

      config.auto_register = %w(
        lib/api/operations
        lib/api/validation
        lib/api/views
      )
    end

    # Copy global app config into place (needed to configure
    # Alpinist::Assets)
    #
    # TODO: make this nicer
    config.options = Alpinist::Container.options

    load_paths! "lib", "core"
  end
end
