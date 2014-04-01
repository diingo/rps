require_relative 'spec_helper.rb'

describe RPS::Round do
  it "exists" do
    expect(RPS::Round).to be_a(Class)
  end

  it "has a match id and winner id" do
    
    round = RPS::Round.new(1,1)
    expect(round.match_id).to eq(1)
    expect(round.winner_id).to eq(1)
  end
end