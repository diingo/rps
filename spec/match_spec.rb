require_relative 'spec_helper.rb'

describe RPS::Match do

  it 'exists' do
    expect(RPS::Match).to be_a(Class)
  end

  it 'has a unique id' do
    RPS::Match.class_variable_set :@@counter, 0
    expect(RPS::Match.new(1,2).id).to eq(1)
    expect(RPS::Match.new(1,2).id).to eq(2)
    expect(RPS::Match.new(1,2).id).to eq(3)
  end

  it "starts with player 1 and player 2" do
    expect(RPS::Match.new(1,2).p_1).to eq(1)
    expect(RPS::Match.new(1,2).p_2).to eq(2)
  end
end