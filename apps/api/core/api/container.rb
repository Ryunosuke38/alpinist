module Api
  class Container < Rodakase::Container
    setting :root, Pathname(__FILE__).join("../..").realpath.dirname.freeze
    setting :auto_register, %w(
      lib/main/operations
      lib/main/validation
      lib/main/views
    )

    configure do
      # Copy global app config into place (needed to configure
      # Alpinist::Assets)
      #
      # TODO: make this nicer
      config.app = Alpinist::Container.config.app

      load_paths! "lib", "core"
    end
  end
end
