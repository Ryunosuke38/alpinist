require "main/authentication/encrypt_password"

RSpec.describe Main::Authentication::EncryptPassword do
  subject(:encrypt_password) { Main::Authentication::EncryptPassword.new }

  it "creates a BCrypt password" do
    expect(encrypt_password.("foo")).to be_a BCrypt::Password
  end

  it "confirms matching passwords" do
    expect(encrypt_password.same?(encrypt_password.("foo"), "foo")).to be_truthy
  end

  it "rejects non-matching passwords" do
    expect(encrypt_password.same?(encrypt_password.("foo"), "bar")).to be_falsey
  end
end
