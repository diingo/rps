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

    it "can create and access all players" do
      player = @db.create_player("Jack")
      retrieved_player = @db.get_player(player.id)

      expect(@db.all_players.first.name).to eq("Jack")
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
  it "can create and get a match" do

  end

  it "can create and access all matchess" do
  end

  it "can update a match" do
  end

  it "can delete a match" do
  end

  ########################
  ## Round CRUD Methods ##
  ########################

  it "can create and get a round" do

  end

  it "can create and access all rounds" do
  end

  it "can update a round" do
  end

  it "can delete a round" do
  end

end