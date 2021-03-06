require_relative 'spec_helper.rb'

describe RPS::Player do
  it "exists" do
    expect(RPS::Player).to be_a(Class)
  end

  it "has a name" do
    player = RPS::Player.new("Jack", 123)
    expect(player.name).to eq("Jack")
  end

  it "has a unique id" do
    RPS::Player.class_variable_set :@@counter, 0
    expect(RPS::Player.new('Estevan', 123).id).to eq(1)
    expect(RPS::Player.new('Estevan', 123).id).to eq(2)
    expect(RPS::Player.new('Estevan', 123).id).to eq(3)
  end

  it "has a password" do
    player = RPS::Player.new("Jack", 123)

    expect(player.password).to eq(123)
  end

end