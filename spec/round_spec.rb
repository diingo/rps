require_relative 'spec_helper.rb'

describe RPS::Round do
  it "exists" do
    expect(RPS::Round).to be_a(Class)
  end

  describe '.initialize' do
    it "generates a unique id for each round" do
      RPS::Round.class_variable_set :@@counter, 0
      expect(RPS::Round.new(1,1).id).to eq(1)
      expect(RPS::Round.new(1,1).id).to eq(2)
      expect(RPS::Round.new(1,1).id).to eq(3)
    end

    it "gives a match id and winner id" do
      round = RPS::Round.new(1,1)
      expect(round.match_id).to eq(1)
      expect(round.winner_id).to eq(1)
    end
  end

end