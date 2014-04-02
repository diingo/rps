require_relative 'spec_helper.rb'

describe RPS::Invite do
  it 'exists' do
    expect(RPS::Invite).to be_a(Class)
  end

  describe '.initialize' do
    it "generates a unique id for each invite" do
      RPS::Invite.class_variable_set :@@counter, 0
      expect(RPS::Invite.new(1,2).id).to eq(1)
      expect(RPS::Invite.new(1,3).id).to eq(2)
      expect(RPS::Invite.new(1,4).id).to eq(3)
    end

    it "gets created with an inviter id and an invitee id" do
      invite = RPS::Invite.new(1,2)
      expect(invite.inviter_id).to eq(1)
      expect(invite.invitee_id).to eq(2)
    end

    it "starts with pending set to true" do
      invite = RPS::Invite.new(1,2)

      expect(invite.pending).to eq(true)
    end
  end
end