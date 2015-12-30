require "main/sessions/sign_in"

RSpec.describe Main::Sessions::SignIn do
  subject(:sign_in) { Main::Sessions::SignIn.new(authenticate) }

  let(:input) { {"email" => "jane@doe.org", "password" => "password1"} }
  let(:session) { double("session") }

  describe "#call" do
    before do
      allow(session).to receive :[]=
    end

    context "authentication succeeds" do
      let(:user) { instance_double(Main::Entities::User, id: 123) }
      let(:authenticate) { instance_double(Main::Authentication::Authenticate, call: user) }

      it "assigns the user ID to the session" do
        expect(session).to receive(:[]=).with :user_id, 123
        sign_in.call(input, session)
      end

      it "returns the user" do
        expect(sign_in.call(input, session)).to eq user
      end
    end

    context "authentication fails" do
      let(:authenticate) { instance_double(Main::Authentication::Authenticate, call: nil) }

      it "assigns no user ID to the session" do
        expect(session).not_to receive :[]=
        sign_in.call(input, session)
      end

      it "returns nil" do
        expect(sign_in.call(input, session)).to be_nil
      end
    end
  end
end
