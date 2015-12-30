Alpinist::Container.namespace "persistence" do |container|
  container.register "create_user" do
    container["persistence.rom"].command(:users)[:create]
  end

  container.register "update_user" do
    container["persistence.rom"].command(:users)[:update]
  end
end
