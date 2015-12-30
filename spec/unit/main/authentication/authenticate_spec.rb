require "db_helper"
require "main/authentication/authenticate"

RSpec.describe Main::Authentication::Authenticate do
  subject(:authenticate) { Main::Authentication::Authenticate.new(encrypt_password, users_repo) }

  let(:encrypt_password) { instance_double(Main::Authentication::EncryptPassword) }
  let(:users_repo) { instance_double(Main::Persistence::Repositories::Users, by_email: user) }

  let(:input) { {"email" => "jane@doe.org", "password" => "foo"} }

  context "user exists" do
    let(:user) { instance_double(Main::Entities::User, encrypted_password: "xyz") }

    it "returns the user if the password matches" do
      expect(encrypt_password).to receive(:same?).with("xyz", "foo").and_return true
      expect(authenticate.(input)).to eq user
    end

    it "returns nil if the password doesn't match" do
      expect(encrypt_password).to receive(:same?).with("xyz", "foo").and_return false
      expect(authenticate.(input)).to be_nil
    end
  end

  context "user doesn't exist" do
    let(:user) { nil }

    it "returns nil" do
      expect(authenticate.(input)).to be_nil
    end
  end
end
