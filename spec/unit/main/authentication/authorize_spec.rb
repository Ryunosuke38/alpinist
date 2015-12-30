require "main/authentication/authorize"

RSpec.describe Main::Authentication::Authorize do
  subject(:authorize) { Main::Authentication::Authorize.new(users_repo) }

  let(:users_repo) { instance_double(Main::Persistence::Repositories::Users) }

  let(:session) { {user_id: 123} }

  context "user exists" do
    let(:user) { instance_double(Main::Entities::User) }

    it "yields the user" do
      expect(users_repo).to receive(:[]).with(123).and_return user

      expect { |b| authorize.(session, &b) }.to yield_with_args(user)
    end
  end

  context "user doesn't exist" do
    let(:user) { nil }

    it "yields nil" do
      expect(users_repo).to receive(:[]).with(123).and_return user

      expect { |b| authorize.(session, &b) }.to yield_with_args(nil)
    end
  end
end
