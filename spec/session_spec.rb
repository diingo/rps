require_relative 'spec_helper.rb'

describe RPS::Session do

  it "exists" do
    expect(RPS::Session).to be_a(Class)
  end

  describe ".initialize" do
    it "generates a unique id for each session" do
      RPS::Session.class_variable_set :@@counter, 0
      expect(RPS::Session.new(1).id).to eq(1)
      expect(RPS::Session.new(1).id).to eq(2)
      expect(RPS::Session.new(1).id).to eq(3)
    end

    it "has a user id" do
      session = RPS::Session.new(1)

      expect(session.user_id).to eq(1)
    end
  end
end