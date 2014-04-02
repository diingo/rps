require_relative 'spec_helper.rb'

describe RPS::Round do
  it "exists" do
    expect(RPS::Round).to be_a(Class)
  end

  describe '.initialize' do
    it "generates a unique id for each round" do
      RPS::Round.class_variable_set :@@counter, 0
      expect(RPS::Round.new(match_id: 1, winner_id: 1, loser_id: 2, p1_choice: "scissors", p2_choice: "paper").id).to eq(1)
      expect(RPS::Round.new(match_id: 1, winner_id: 1, loser_id: 2, p1_choice: "scissors", p2_choice: "paper").id).to eq(2)
      expect(RPS::Round.new(match_id: 1, winner_id: 1, loser_id: 2, p1_choice: "scissors", p2_choice: "paper").id).to eq(3)
    end

    it "gives a match id, winner id, and loser id" do
      round = RPS::Round.new(match_id: 1, winner_id: 1, loser_id: 2, p1_choice: "scissors", p2_choice: "paper")
      expect(round.match_id).to eq(1)
      expect(round.winner_id).to eq(1)
      expect(round.loser_id).to eq(2)
    end

    it "gives player 1 choice and player 2 choice" do
      round = RPS::Round.new(match_id: 1, winner_id: 1, loser_id: 2, p1_choice: "scissors", p2_choice: "paper")

      expect(round.p1_choice).to eq("scissors")
      expect(round.p2_choice).to eq("paper")
    end
  end

end