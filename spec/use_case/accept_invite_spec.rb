require_relative "../spec_helper.rb"

describe RPS::AcceptInvite, pending: true do
  before do
    @p1 = RPS.db.create_player("Jack", "123")
    @p2 = RPS.db.create_player("Zel", "012")
    @session = RPS.db.create_session(@p1.id)
    @session_key = @session.id
    @invite = RPS.db.create_invite(@p1.id, @p2.id)
  end

  xit 'exists' do
    expect(RPS::AcceptInvite).to be_a(Class)
  end

  context "success" do
  end

  context "failure" do
    xit "errors if iid does not exist" do

      result = RPS::AcceptInvite.run()
    end
    xit "errors if player is not an invitee of the invite" do
    end
  end
end