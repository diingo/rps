require_relative "../spec_helper.rb"

describe RPS::AcceptInvite do
  before do
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