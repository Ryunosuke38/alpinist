require "db_helper"
require "main/operations/create_user"

RSpec.describe Main::Operations::CreateUser do
  subject(:create_user) { Main::Operations::CreateUser.new(encrypt_password) }

  let(:encrypt_password) { instance_double(Main::Authentication::EncryptPassword) }

  context "valid params" do
    let(:input) {
      {
        "name" => "Jane Doe",
        "email" => "jane@doe.org",
        "password" => "abc",
        "password_confirmation" => "abc",
      }
    }

    it "creates a user with an encrypted password" do
      expect(encrypt_password).to receive(:call).with("abc").and_return("abc-encrypted")

      result = create_user.(input)
      expect(result).to be_a Kleisli::Either::Right

      user = result.value
      expect(user.name).to eq "Jane Doe"
      expect(user.email).to eq "jane@doe.org"
      expect(user.encrypted_password).to eq "abc-encrypted"
    end
  end

  context "invalid params" do
    let(:input) { {"name" => ""} }

    it "returns a failure" do
      result = create_user.(input)

      expect(result).to be_a Kleisli::Either::Left
    end
  end
end
