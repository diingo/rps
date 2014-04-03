require_relative "../spec_helper.rb"

describe RPS::CreateInvite do
  before do
    @p1 = RPS.db.create_player("Jack", "123")
    @p2 = RPS.db.create_player("Zel", "012")
    sign_in_result = RPS::SignIn.run({ username: @p1.name, password: @p1.password })
    @session_key = sign_in_result.session_key
  end

  xit 'exists' do
    expect(RPS::CreateInvite).to be_a(Class)
  end

  context "success" do
    it "create an invite" do
      result = RPS::CreateInvite.run({ session_key: @session_key, invitee_id: @p2.id})

      expect(result.success?).to eq(true)
      expect(result.invite.inviter_id).to eq(@p1.id)
      expect(result.invite.invitee_id).to eq(@p2.id)
      expect(result.inviter_name).to eq("Jack")
      expect(result.invitee_name).to eq("Zel")
    end
  end

  context "failure" do
    it "errors if invitee does not exist" do
      result = RPS::CreateInvite.run({ session_key: @session_key, invitee_id: 999})

      expect(result.error?).to eq(true)
      expect(result.error).to eq(:invitee_nonexistent)
    end
  end
end