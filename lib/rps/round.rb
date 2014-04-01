module RPS

  class Round
    attr_reader :match_id, :winner_id
    
    def initialize(match_id, winner_id)
      @match_id = match_id
      @winner_id = winner_id
    end
  end
end