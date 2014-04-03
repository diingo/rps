require_relative '../spec_helper.rb'

describe RPS::SignUp do
  it 'exists' do
    expect(RPS::SignUp).to be_a(Class)
  end

  it "creates a new user when they sign up" do
    username = "Bob"
    pw = "123"
    result = RPS::SignUp.run({ username: username, password: pw })
    player = RPS.db.find_player_by_username(username)

    expect(result.success?).to eq(true)
    expect(result.player.id).to eq(player.id)
  end

  it "errors if the username is already taken" do
    username = "Jack"
    pw = "123"
    RPS.db.create_player(username, pw)
    result = RPS::SignUp.run({ username: username, password: pw })

    expect(result.error?).to eq(true)
    expect(result.error).to eq(:username_taken)
  end
end