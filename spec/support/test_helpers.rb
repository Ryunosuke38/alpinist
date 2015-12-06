module TestHelpers
  module_function

  def container
    Alpinist::Container
  end

  def app
    Alpinist::Application.app
  end

  def rom
    container["persistence.rom"]
  end

  def db_connection
    rom.gateways[:default].connection
  end
end
