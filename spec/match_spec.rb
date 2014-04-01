require_relative 'spec_helper.rb'

describe RPS::Match do

  it 'exists' do
    expect(RPS::Match).to be_a(Class)
  end

  it 'has a unique id' do
    RPS::Match.class_variable_set :@@counter, 0
    expect(RPS::Match.new.id).to eq(1)
    expect(RPS::Match.new.id).to eq(2)
    expect(RPS::Match.new.id).to eq(3)
  end

  it "defaults has having player 1 and player 2 set to nil" do
    expect(RPS::Match.new.p_1).to be_nil
    expect(RPS::Match.new.p_2).to be_nil
  end
end