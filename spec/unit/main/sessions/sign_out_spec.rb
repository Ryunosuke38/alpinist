require "main/sessions/sign_out"

RSpec.describe Main::Sessions::SignOut do
  subject(:sign_out) { Main::Sessions::SignOut.new }

  let(:session) { double("session") }

  describe "#call" do
    it "sets the session's user ID to nil" do
      expect(session).to receive(:[]=).with :user_id, nil
      sign_out.(session)
    end
  end
end
