require_relative "../core/boot"

encrypt_password = Alpinist::Container["main.sessions.encrypt_password"]
create_user = Alpinist::Container["persistence.rom"].command(:users).create

%w(max michael tim).each do |name|
  create_user.(name: name.capitalize, email: "#{name}@example.com", encrypted_password: encrypt_password.("password1"))
end
