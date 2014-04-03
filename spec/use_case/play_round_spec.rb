require_relative "../spec_helper.rb"

describe RPS::PlayRound, pending: true do
  before do
    @p1 = RPS.db.create_player("Jack", "123")
    @p2 = RPS.db.create_player("Zel", "012")
    match = RPS.create_match(@p1.id, @p2.id)
    @session_key = RPS.db.create_session(@p1.id).id
  end

  xit 'exists' do
    expect(RPS::PlayRound).to be_a(Class)
  end

  context "success" do
    it "updates a round if it's blank" do
      result = RPS::PlayRound({session_key: @session_key, choice: "rock"})
      expect(result.round.winner).to be_nil

    end
  end

  context "failure" do
    xit "errors if iid does not exist" do

      result = RPS::AcceptInvite.run()
    end
    xit "errors if player is not an invitee of the invite" do
    end
  end
end