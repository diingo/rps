require_relative '../spec_helper.rb'

describe RPS::SignIn do
  it 'exists' do
    expect(RPS::SignIn).to be_a(Class)
  end

  context "success" do
    it 'creates a session for the player' do
      username = "Jack"
      pw = "123"
      player = RPS.db.create_player(username, pw)
      result = RPS::SignIn.run({ username: username, password: pw })

      expect(result.success?).to eq(true)
      expect(result.session.user_id).to eq(player.id)
      expect(result.session_key).to eq(result.session.id)
    end
  end

  context "failure" do
    it "errors if name does not exist" do
      username = "Jack"
      pw = "123"
      result = RPS::SignIn.run({ username: username, password: pw })

      expect(result.error?).to eq(true)
      expect(result.error).to eq(:player_nonexistent)
    end

    it "errors if password is incorrect" do
      username = "Jack"
      pw = "123"
      wrong_pw = "245"
      player = RPS.db.create_player(username, pw)
      result = RPS::SignIn.run({ username: username, password: wrong_pw })

      expect(result.error?).to eq(true)
      expect(result.error).to eq(:incorrect_password)
    end
  end
end