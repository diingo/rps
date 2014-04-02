require_relative 'spec_helper.rb'

describe RPS::DB do
  before do
    @db = RPS.db
  end

  it "exists" do
    expect(RPS::DB).to be_a(Class)
  end

  it "starts with no players, no rounds, no matches" do
    expect(@db.all_players.empty?).to eq(true)
    expect(@db.all_matches.empty?).to eq(true)
    expect(@db.all_rounds.empty?).to eq(true)
  end

  #########################
  ## Player CRUD Methods ##
  #########################

  describe "Player CRUD Methods" do
    before do
      @player = @db.create_player("Jack")
    end

    it "can create and get a player" do
      player = @db.create_player("Jack")
      retrieved_player = @db.get_player(player.id)

      expect(retrieved_player.name).to eq("Jack")
    end

    it "can access all players" do
      expect(@db.all_players.first.name).to eq("Jack")
      expect(@db.all_players.size).to eq(1)
    end

    it "can update a player" do
      expect(@player.name).to eq("Jack")

      @db.update_player(@player.id, "Johnny")
      expect(@player.name).to eq("Johnny")
    end

    it "can delete a player" do
      expect(@db.all_players.length).to eq(1)

      @db.delete_player(@player.id)
      expect(@db.all_players.length).to eq(0)
      expect(@db.get_player(@player.id)).to be_nil
    end
  end

  ########################
  ## Match CRUD Methods ##
  ########################

  describe "Match CRUD Methods" do
    before do
      @p1 = @db.create_player("Johnny")
      @p2 = @db.create_player("Sassa")
    end

    # TO DO - is this test ok
    it "can create and get a new match" do
      match = @db.create_match(@p1.id, @p2.id)
      # binding.pry
      retrieved_match = @db.get_match(match.id)

      expect(retrieved_match.p1_id).to eq(@p1.id)
      expect(retrieved_match.p2_id).to eq(@p2.id)
      expect(retrieved_match.winner).to be_nil
    end

    it "can create and access all matchess" do
      match = @db.create_match(@p1.id, @p2.id)

      expect(@db.all_matches.size).to eq(1)
      expect(@db.all_matches.first.p1_id).to eq(@p1.id)
    end

    it "can update a match" do
      match = @db.create_match(@p1.id, @p2.id)
      updated_match = @db.update_match(match.id, { winner: @p1.id })

      expect(match.winner).to eq(@p1.id)
    end

    it "can delete a match" do
      match = @db.create_match(@p1.id, @p2.id)
      retrieved_match = @db.get_match(match.id)
      expect(retrieved_match).to_not be_nil

      @db.delete_match(match.id)
      retrieved_match = @db.get_match(match.id)
      expect(retrieved_match).to be_nil
    end
  end

  ########################
  ## Round CRUD Methods ##
  ########################

  describe "Round CRUD Methods" do
    before do
      @p1 = @db.create_player("Johnny")
      @p2 = @db.create_player("Sassa")
      @match = @db.create_match(@p1.id, @p2.id)
    end

    it "can create and get a round" do
      round = @db.create_round({ match: @match.id , winner: @p1.id })

      expect(round.winner_id).to eq(@p1.id)
      expect(round.match_id).to eq(@match.id)
    end

    it "can create and access all rounds" do
      round = @db.create_round({ match: @match.id , winner: @p1.id })

      expect(@db.all_rounds.size).to eq(1)
      expect(@db.all_rounds.first.winner_id).to eq(@p1.id)
    end

    # leave pending for now, may not ever need them
    xit "can update a round" do
      round = @db.create_round({ match: @match.id , winner: @p1.id })
    end

    xit "can delete a round" do
    end
  end

end