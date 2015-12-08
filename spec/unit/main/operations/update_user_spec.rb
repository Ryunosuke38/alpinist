require "db_helper"
require "main/operations/update_user"

RSpec.describe Main::Operations::UpdateUser do
  subject(:update_user) { Main::Operations::UpdateUser.new(encrypt_password) }

  let(:encrypt_password) { instance_double(Main::Authentication::EncryptPassword) }

  let!(:user_id) {
    Alpinist::Container["persistence.create_user"].(
      name: "Jane Doe",
      email: "jane@doe.org",
      encrypted_password: "zzz"
    ).fetch(:id)
  }

  context "valid params, including password" do
    let(:input) {
      {
        "name" => "New Jane Doe",
        "email" => "new.jane@doe.org",
        "password" => "abc",
        "password_confirmation" => "abc",
      }
    }

    it "updates the user with an encrypted password" do
      expect(encrypt_password).to receive(:call).with("abc").and_return("abc-encrypted")

      result = update_user.(user_id, input)
      expect(result).to be_a Kleisli::Either::Right

      user = result.value
      expect(user.name).to eq "New Jane Doe"
      expect(user.email).to eq "new.jane@doe.org"
      expect(user.encrypted_password).to eq "abc-encrypted"
    end
  end

  context "valid params, without password" do
    let(:input) {
      {
        "name" => "New Jane Doe",
        "email" => "new.jane@doe.org",
      }
    }

    it "updates the user without any changes to the password" do
      expect(encrypt_password).not_to receive(:call)

      result = update_user.(user_id, input)
      expect(result).to be_a Kleisli::Either::Right

      user = result.value
      expect(user.name).to eq "New Jane Doe"
      expect(user.email).to eq "new.jane@doe.org"
      expect(user.encrypted_password).to eq "zzz"
    end
  end

  context "invalid params" do
    let(:input) { {"name" => ""} }

    it "returns a failure" do
      result = update_user.(user_id, input)

      expect(result).to be_a Kleisli::Either::Left
    end
  end
end
